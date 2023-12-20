return {
	"nvimtools/none-ls.nvim", -- configure formatters & linters
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to enable uncomment this
	dependencies = {
		"jay-babu/mason-null-ls.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason_null_ls = require("mason-null-ls")
		local mason_tool_installer = require("mason-tool-installer")

		local null_ls = require("null-ls")
		local null_ls_utils = require("null-ls.utils")

		mason_tool_installer.setup({
			ensure_installed = {
				"prettierd",
				"shfmt",
				"stylua",
				"black",
				"pylint",
				"eslint_d",
			},
		})

		mason_null_ls.setup({
			ensure_installed = {
				"prettier",
				"shfmt",
				"stylua",
				"black",
				"pylint",
				"eslint_d",
			},
		})

		-- for conciseness
		local formatting = null_ls.builtins.formatting

		null_ls.setup({
			-- add package.json as identifier for root (for typescript monorepos)
			root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
			-- setup formatters & linters
			sources = {
				--  to disable file types use
				--  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
				formatting.prettier.with({
					extra_filetypes = { "svelte" },
				}),
				formatting.stylua,
				formatting.isort,
				formatting.black,
                formatting.shfmt
			},
		})
	end,
}
