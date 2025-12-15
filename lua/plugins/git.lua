return {
	"tpope/vim-fugitive",
	enabled = false,
	config = function()
		vim.keymap.set("n", "<leader>lg", vim.cmd.Git)
	end,
}
