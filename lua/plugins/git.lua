return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>lg", vim.cmd.Git)
	end,
}
