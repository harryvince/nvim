return {
    'voldikss/vim-floaterm',
    config = function ()
        local options = { noremap = true, silent = true }

        vim.keymap.set('n', '<leader>ld', '<CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 lazydocker<CR>', options)
        vim.keymap.set('n', '<leader>lg', '<CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 lazygit<CR>', options)
    end
}
