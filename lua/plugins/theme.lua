return {
	"rose-pine/neovim",
	name = "rose-pine",
	priority = 1000,
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("rose-pine").setup({
			variant = "moon",
			dim_inactive_windows = true,
			styles = {
				bold = false,
				italic = false,
				transparency = false,
			},
		})

		vim.cmd.colorscheme("rose-pine")
		vim.opt.fillchars = { eob = " " }
	end,
}
