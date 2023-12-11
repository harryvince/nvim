return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "macchiato",     -- latte, frappe, macchiato, mocha
            transparent_background = false,
            show_end_of_buffer = false,
            term_colors = true,
            dim_inactive = {
                enabled = true,
            },
            integrations = {
                gitsigns = true,
                telescope = {
                    enabled = true,
                },
                noice = true,
                cmp = true,
                harpoon = true,
                mason = true,
                treesitter_context = true,
                treesitter = true,
                dap = true,
                dap_ui = true,
            },
        })
        vim.cmd.colorscheme "catppuccin"
    end
}
