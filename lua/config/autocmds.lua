vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = "*.tf",
	command = "set filetype=terraform",
})
