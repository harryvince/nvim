return {
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
		"Fildo7525/pretty_hover",

		-- Schema information
		"b0o/SchemaStore.nvim",
	},
	config = function()
		---@diagnostic disable-next-line: unused-function
		local extend = function(name, key, values)
			local mod = require(string.format("lspconfig.configs%s", name))
			local default = mod.default_config
			local keys = vim.split(key, ".", { plain = true })
			while #keys > 0 do
				local item = table.remove(keys, 1)
				default = default[item]
			end

			if vim.islist(default) then
				for _, value in ipairs(default) do
					table.insert(values, value)
				end
			else
				for item, value in pairs(default) do
					if not vim.tbl_contains(values, item) then
						values[item] = value
					end
				end
			end
		end

        local capabilities = require('blink.cmp').get_lsp_capabilities()

		local lspconfig = require("lspconfig")

		local servers = {
			bashls = true,
			dockerls = true,
			lua_ls = {
				server_capabilities = {
					semanticTokensProvider = vim.NIL,
				},
			},
			pyright = true,
			biome = {
				root_dir = lspconfig.util.root_pattern("biome.json"),
			},
			ts_ls = {
				root_dir = lspconfig.util.root_pattern("package.json"),
				single_file_support = false,
				server_capabilities = {
					documentFormattingProvider = false,
				},
			},
			denols = {
				root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
			},
			jsonls = {
				server_capabilities = {
					documentFormattingProvider = false,
				},
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			},
			yamlls = {
				settings = {
					yaml = {
						schemaStore = {
							enable = false,
							url = "",
						},
					},
				},
			},
			tailwindcss = {
				filetypes = { "javascriptreact", "typescriptreact", "astro", "astro-markdown", "svelte" },
			},
			terraformls = true,
			nil_ls = {
				manual_install = true,
			},
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
		local ensure_installed = {
			"stylua",
			"prettier",
			"shfmt",
		}

		vim.list_extend(ensure_installed, servers_to_install)
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		for name, config in pairs(servers) do
			if config == true then
				config = {}
			end
			config = vim.tbl_deep_extend("force", {}, {
				capabilities = capabilities,
			}, config)

			lspconfig[name].setup(config)
		end

		local disable_semantic_tokens = {
			lua = true,
		}

		require("pretty_hover").setup({})

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
				vim.keymap.set("n", "K", function()
					require("pretty_hover").hover()
				end, { buffer = 0 })
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
}
