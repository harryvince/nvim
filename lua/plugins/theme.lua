return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			transparent_background = false,
			show_end_of_buffer = false,
			term_colors = true,
			dim_inactive = {
				enabled = false,
			},
			integrations = {
				gitsigns = true,
				telescope = {
					enabled = true,
					style = "nvchad",
				},
				noice = false,
				cmp = true,
				harpoon = true,
				mason = true,
				treesitter_context = true,
				treesitter = true,
				dap = true,
				dap_ui = true,
			},
			color_overrides = {
				mocha = {
					base = "#000000",
					mantle = "#000000",
					crust = "#000000",
				},
			},
			custom_highlights = function(colors)
				return {
					-- LineNr = { fg = colors.yellow },
					GitSignsCurrentLineBlame = { fg = colors.flamingo },
				}
			end,
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
