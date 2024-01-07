return {
	"neovim/nvim-lspconfig",
	event = "VeryLazy",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
		"williamboman/mason-lspconfig.nvim",
		"williamboman/mason.nvim",
	},
	config = function()
		local lsp = require("lsp-zero")

		lsp.on_attach(function(client, _)
			if client.name ~= "null-ls" then
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentFormattingRangeProvider = false
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
		end)

		lsp.set_preferences({
			sign_icons = { error = "E", warn = "W", hint = "H", info = "I" },
		})

		lsp.configure("lua_ls", {
			settings = {
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
					telemetry = {
						enabled = false,
					},
				},
			},
		})

		lsp.configure("ansiblels", {
			filetypes = {
				"yaml.ansible",
			},
		})

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"tsserver",
				"html",
				"cssls",
				"svelte",
				"lua_ls",
				"pyright",
				"bashls",
				"jsonls",
			},
			automatic_installation = true,
			handlers = {
				lsp.default_setup,
			},
		})
	end,
}
