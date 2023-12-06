return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.x',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-tree/nvim-web-devicons' },
    },
    event = 'VeryLazy',
    config = function()
        require('telescope').setup({
            pickers = {
                find_files = {
                    disable_devicons = false
                }
            }
        })
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<leader>bf', builtin.buffers, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>se', builtin.diagnostics, {})
    end,
}
