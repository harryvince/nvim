return {
	"neovim/nvim-lspconfig",
	event = "VeryLazy",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"williamboman/mason-lspconfig.nvim",
		"williamboman/mason.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local servers = {
			"ts_ls",
			"html",
			"cssls",
			"svelte",
			"lua_ls",
			"pyright",
			"bashls",
			"jsonls",
			"ansiblels",
		}

		local disable_formatting = {
			"ts_ls",
			"html",
			"cssls",
			"svelte",
			"lua_ls",
			"bashls",
			"jsonls",
		}

		local capabilities = cmp_nvim_lsp.default_capabilities()
		local on_attach = function(client, _)
			for _, value in ipairs(disable_formatting) do
				if client.name == value then
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentFormattingRangeProvider = false
				end
			end

			if client.name == "svelte" then
				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts" },
					callback = function(ctx)
						if client.name == "svelte" then
							client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
						end
					end,
				})

				vim.api.nvim_create_autocmd({ "BufWrite" }, {
					group = vim.api.nvim_create_augroup("svelte_ondidchangetsorjsfile", { clear = true }),
					pattern = { "+page.server.ts", "+page.ts", "+layout.server.ts", "+layout.ts" },
					command = 'lua require("config.utils").svelteFix()',
				})
			end
		end

		local setup_lsp = function(server_name)
			local opts = { on_attach = on_attach, capabilities = capabilities }
			if server_name == "lua_ls" then
				opts.settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
						telemetry = { enabled = false },
					},
				}
			end

			return opts
		end

		local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = servers,
			automatic_installation = true,
			handlers = {
				function(server_name)
					lspconfig[server_name].setup(setup_lsp(server_name))
				end,
			},
		})
	end,
}
