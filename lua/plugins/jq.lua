return {
	"yochem/jq-playground.nvim",
	event = "VeryLazy",
	config = function()
		vim.keymap.set("n", "<leader>jq", vim.cmd.JqPlayground)
	end,
}
