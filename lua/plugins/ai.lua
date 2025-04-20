return {
	{
		"supermaven-inc/supermaven-nvim",
		cond = require("config.utils").is_personal,
		opts = {
			keymaps = {
				accept_suggestion = "<S-Tab>",
			},
		},
	},
	{
		"frankroeder/parrot.nvim",
		dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim" },
		cond = require("config.utils").is_personal,
		opts = {
			providers = {
				anthropic = {
					api_key = os.getenv("ANTHROPIC_API_KEY"),
				},
			},
		},
	},
}
