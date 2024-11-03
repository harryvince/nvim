local local_vimrc = vim.fn.getcwd() .. "/.nvimrc"
if vim.fn.filereadable(local_vimrc) == 1 then
	vim.cmd("source " .. local_vimrc)
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.yaml.ansible" },
	command = "set filetype=yaml.ansible",
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "justfile" },
	command = "set filetype=just",
})
