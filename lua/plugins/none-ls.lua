return {
	"nvimtools/none-ls.nvim",
	lazy = true,
	event = "VeryLazy",
	dependencies = {
		"jay-babu/mason-null-ls.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason_null_ls = require("mason-null-ls")
		local mason_tool_installer = require("mason-tool-installer")

		local null_ls = require("null-ls")
		local null_ls_utils = require("null-ls.utils")

		local tools = { "prettierd", "shfmt", "stylua", "black", "pylint", "eslint_d" }

		mason_tool_installer.setup({
			ensure_installed = tools,
		})

		mason_null_ls.setup({
			ensure_installed = tools,
		})

		-- for conciseness
		local formatting = null_ls.builtins.formatting

		null_ls.setup({
			root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
			sources = {
				formatting.prettier.with({
					extra_filetypes = { "svelte" },
				}),
				formatting.stylua,
				formatting.isort,
				formatting.black,
				formatting.shfmt,
			},
		})
	end,
}
