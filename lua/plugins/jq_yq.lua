return {
	"harryvince/jq-playground.nvim",
	dev = false,
	event = "VeryLazy",
	config = function()
		vim.keymap.set("n", "<leader>jq", vim.cmd.JqPlayground)
	end,
}
