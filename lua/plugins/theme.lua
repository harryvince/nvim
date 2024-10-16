return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			transparent_background = true,
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
			custom_highlights = function(colors)
				return {
                    TelescopeBorder = {
                        fg = colors.mantle,
                        bg = colors.mantle,
                    },
                    TelescopeMatching = { fg = colors.blue },
                    TelescopeNormal = {
                        bg = colors.mantle,
                    },
                    TelescopePromptBorder = {
                        fg = colors.surface0,
                        bg = colors.surface0,
                    },
                    TelescopePromptNormal = {
                        fg = colors.text,
                        bg = colors.surface0,
                    },
                    TelescopePromptPrefix = {
                        fg = colors.flamingo,
                        bg = colors.surface0,
                    },
                    TelescopePreviewTitle = {
                        fg = colors.base,
                        bg = colors.green,
                    },
                    TelescopePromptTitle = {
                        fg = colors.base,
                        bg = colors.red,
                    },
                    TelescopeResultsTitle = {
                        fg = colors.mantle,
                        bg = colors.lavender,
                    },
                    TelescopeSelection = {
                        fg = colors.text,
                        bg = colors.surface0,
                        style = { "bold" },
                    },
                    TelescopeSelectioncolorsaret = { fg = colors.flamingo },
                    LineNr = { fg = colors.yellow },
                    GitSignsCurrentLineBlame = { fg = colors.flamingo },
				}
			end,
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
