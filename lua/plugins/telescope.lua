return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-tree/nvim-web-devicons" },
		{ "aznhe21/actions-preview.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	event = "VeryLazy",
	config = function()
		local picker_opts = { theme = "ivy" }

		require("telescope").setup({
			extensions = {
				fzf = {},
			},
			pickers = {
				find_files = picker_opts,
				git_files = picker_opts,
				grep_string = picker_opts,
				live_grep = picker_opts,
			},
		})

		require("telescope").load_extension("fzf")

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>pf", builtin.find_files)
		vim.keymap.set("n", "<leader>bf", builtin.buffers)
		vim.keymap.set("n", "<C-p>", builtin.git_files)
		vim.keymap.set("n", "<leader>ps", builtin.live_grep)
	end,
}
