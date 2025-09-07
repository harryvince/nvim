return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						-- Load luvit types when the `vim.uv` word is found
						{ path = "luvit-meta/library", words = { "vim%.uv" } },
					},
				},
			},
			{ "Bilal2453/luvit-meta", lazy = true },
			"saghen/blink.cmp",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"j-hui/fidget.nvim",
			{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },

			-- Schema information
			"b0o/SchemaStore.nvim",
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local lspconfig = require("lspconfig")

			local servers = {
				astro = {
					init_options = {
						typescript = {
							tsdk = vim.fn.expand(
								"~/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib"
							),
						},
					},
				},
				bashls = true,
				dockerls = true,
				lua_ls = { server_capabilities = { semanticTokensProvider = vim.NIL } },
				biome = { root_dir = lspconfig.util.root_pattern("biome.json") },
				ts_ls = {
					root_dir = lspconfig.util.root_pattern("package.json"),
					single_file_support = false,
					server_capabilities = { documentFormattingProvider = false },
				},
				denols = {
					manual_install = true,
					root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
				},
				jsonls = {
					server_capabilities = { documentFormattingProvider = false },
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},
				yamlls = {
					settings = {
						redhat = { telemetry = { enabled = false } },
						yaml = {
							schemaStore = { enable = false, url = "" },
							schemas = {
								["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
								["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
								["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*gitlab-ci*.{yml,yaml}",
								["https://json.schemastore.org/pre-commit-config.json"] = ".pre-commit-config.{yml,yaml}",
								["https://raw.githubusercontent.com/F1bonacc1/process-compose/refs/heads/main/schemas/process-compose-schema.json"] = "process-compose.yaml",
							},
						},
					},
				},
				tailwindcss = {
					filetypes = { "javascriptreact", "typescriptreact", "astro", "astro-markdown", "svelte" },
				},
				terraformls = true,
				nil_ls = { manual_install = true },
				gopls = true,
				jdtls = true,
				rust_analyzer = true,
				basedpyright = true,
				ruff = true,
			}

			local servers_to_install = vim.tbl_filter(function(key)
				local t = servers[key]
				if type(t) == "table" then
					return not t.manual_install
				else
					return t
				end
			end, vim.tbl_keys(servers))

			require("mason").setup()
			local tooling = { "stylua", "prettier", "shfmt" }

			vim.list_extend(tooling, servers_to_install)
			require("mason-tool-installer").setup({ ensure_installed = tooling })

			for name, config in pairs(servers) do
				if config == true then
					config = {}
				end
				config = vim.tbl_deep_extend("force", {}, {
					capabilities = capabilities,
				}, config)

				lspconfig[name].setup(config)
			end

			local disable_semantic_tokens = { lua = true }

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

					local settings = servers[client.name]
					if type(settings) ~= "table" then
						settings = {}
					end

					local builtin = require("telescope.builtin")

					vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
					vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
					vim.keymap.set("n", "<leader>rr", builtin.lsp_references, { buffer = 0 })
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
					vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
					vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, { buffer = 0 })

					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = 0 })
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })

					local filetype = vim.bo[bufnr].filetype
					if disable_semantic_tokens[filetype] then
						client.server_capabilities.semanticTokensProvider = nil
					end

					if settings.server_capabilities then
						for k, v in pairs(settings.server_capabilities) do
							if v == vim.NIL then
								---@diagnostic disable-next-line: cast-local-type
								v = nil
							end

							client.server_capabilities[k] = v
						end
					end

					-- Disable lsp if a matching comment is found
					local first_line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1]
					if first_line:find("lsp:disable") and first_line:find(client.name) then
						---@diagnostic disable-next-line: missing-parameter
						client.stop()
						return
					end
				end,
			})

			require("lsp_lines").setup()
			vim.diagnostic.config({ virtual_text = true, virtual_lines = false })

			vim.keymap.set("", "<leader>ll", function()
				local config = vim.diagnostic.config() or {}
				if config.virtual_text then
					vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
				else
					vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
				end
			end)

			require("fidget").setup({
				notification = { window = { winblend = 0 } },
			})
		end,
	},
	{
		"supermaven-inc/supermaven-nvim",
		cond = require("config.utils").is_personal,
		opts = { keymaps = { accept_suggestion = "<S-Tab>" } },
	},
}
