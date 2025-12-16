return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-tree/nvim-web-devicons" },
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	event = "VeryLazy",
	config = function()
		require("telescope").setup({
			defaults = {
				results_title = false,
				layout_config = {
					horizontal = {
						preview_width = 0.55,
						results_width = 0.8,
					},
					vertical = { mirror = false },
					width = 0.85,
					height = 0.92,
					preview_cutoff = 120,
				},
				file_ignore_patterns = {
					"node_modules",
					".git/",
					".venv/",
				},
			},
			extensions = {
				fzf = {},
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
			pickers = {
				find_files = { hidden = true, disable_devicons = true },
				buffers = { disable_devicons = true },
				git_files = { disable_devicons = true },
				live_grep = { additional_args = { "--hidden" }, disable_devicons = true },
				current_buffer_fuzzy_find = {
					disable_devicons = true,
					theme = "dropdown",
					layout_config = {
						anchor = "N",
						height = 0.35,
						mirror = true,
						width = 0.55,
					},
				},
			},
		})

		require("telescope").load_extension("fzf")
		require("telescope").load_extension("ui-select")

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
		vim.keymap.set("n", "<leader>bf", builtin.buffers, {})
		vim.keymap.set("n", "<C-p>", builtin.git_files, {})
		vim.keymap.set("n", "<leader>ps", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, {})
		vim.keymap.set("n", "<leader>sp", function()
			builtin.spell_suggest(require("telescope.themes").get_cursor({}))
		end, {})
	end,
}
