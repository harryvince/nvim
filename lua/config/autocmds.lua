local local_vimrc = vim.fn.getcwd() .. "/.nvimrc"
if vim.fn.filereadable(local_vimrc) == 1 then
	vim.cmd("source " .. local_vimrc)
end
