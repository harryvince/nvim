return {
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        'nvim-treesitter/nvim-treesitter-context',
    },
    config = function()
        require 'nvim-treesitter.configs'.setup {
            ensure_installed = { "javascript", "typescript", "lua", "vim", "python" },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        }
    end
}
