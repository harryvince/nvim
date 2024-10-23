return {
	"nvimtools/none-ls.nvim",
	lazy = true,
	event = "VeryLazy",
	dependencies = {
		"jay-babu/mason-null-ls.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local null_ls_utils = require("null-ls.utils")

		local tools = {
            "prettier",
			"prettierd",
			"shfmt",
			"stylua",
			"black",
			"pylint",
			"eslint_d",
			"ansible-lint",
            "djlint"
		}

		require("mason-tool-installer").setup({ ensure_installed = tools })
		require("mason-null-ls").setup({ ensure_installed = tools })

		-- for conciseness
		local formatting = null_ls.builtins.formatting

		null_ls.setup({
			root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
			sources = {
				formatting.prettier.with({
					extra_filetypes = { "svelte" },
				}),
                formatting.biome.with({
                    condition = function(utils)
                        return utils.root_has_file({ "biome.json" })
                    end
                }),
				formatting.stylua,
				formatting.isort,
				formatting.black,
				formatting.shfmt,
                formatting.djlint,
                formatting.nixpkgs_fmt,
			},
		})
	end,
}
