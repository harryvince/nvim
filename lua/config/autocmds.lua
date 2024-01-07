vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"*.yaml.ansible"},
    command = "set filetype=yaml.ansible"
})

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"justfile"},
    command = "set filetype=just"
})
