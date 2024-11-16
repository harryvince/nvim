return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-tree/nvim-web-devicons" },
        { "aznhe21/actions-preview.nvim" },
	},
	event = "VeryLazy",
	config = function()
		require("telescope").setup({
			defaults = {
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
						results_width = 0.8,
					},
					vertical = {
						mirror = false,
					},
					width = 0.85,
					height = 0.92,
					preview_cutoff = 120,
				},
			},
			pickers = {
				find_files = { disable_devicons = true },
				buffers = { disable_devicons = true },
				git_files = { disable_devicons = true },
				live_grep = { disable_devicons = true },
			},
		})
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
		vim.keymap.set("n", "<leader>bf", builtin.buffers, {})
		vim.keymap.set("n", "<C-p>", builtin.git_files, {})
		vim.keymap.set("n", "<leader>ps", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>ca", require("actions-preview").code_actions, {})
	end,
}
