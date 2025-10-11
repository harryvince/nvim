return {
	"datsfilipe/vesper.nvim",
	dev = false,
	config = function()
		require("vesper").setup({
			italics = {
				keywords = false,
				functions = false,
				strings = false,
				variables = false,
			},
		})
		vim.cmd.colorscheme("vesper")

		vim.cmd("highlight NormalFloat guibg=NONE")
		vim.opt.fillchars = { eob = " " }
	end,
}
