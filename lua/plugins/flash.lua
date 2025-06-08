return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = { keymaps = false },
	keys = {
		{
			"zk",
			mode = { "n" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
	},
}
