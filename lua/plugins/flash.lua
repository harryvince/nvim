return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
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
