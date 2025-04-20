return {
	{
		"harryvince/vesper.nvim",
		dev = false,
		config = function()
			require("vesper").setup({
				transparent = false,
				italics = {
					comments = true,
					keywords = false,
					functions = false,
					strings = true,
					variables = false,
				},
				overrides = {},
				palette_overrides = {},
			})
			vim.cmd.colorscheme("vesper")

			vim.opt.fillchars = { eob = " " }
			-- vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = "#292925", fg = "#ffffff", bold = true })
			-- vim.api.nvim_set_hl(0, "TelescopeTitle", { bg = "#ffcfa8", fg = "#101010", bold = true })
			-- vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = "#ffcfa8" })
		end,
	},
}
