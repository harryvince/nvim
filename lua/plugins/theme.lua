return {
	{
		"datsfilipe/vesper.nvim",
		dev = false,
		config = function()
			require("vesper").setup({
				transparent = false,
				italics = {
					comments = true,
					keywords = false,
					functions = false,
					strings = false,
					variables = false,
				},
				overrides = {},
				palette_overrides = {},
			})
			vim.cmd.colorscheme("vesper")

			vim.opt.fillchars = { eob = " " }
		end,
	},
}
