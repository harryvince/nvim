local local_vimrc = vim.fn.getcwd() .. "/.nvimrc"
if vim.fn.filereadable(local_vimrc) == 1 then
	vim.cmd("source " .. local_vimrc)
end

require("config.keymaps")
require("config.set")
require("config.utils")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
	{ import = "plugins" },
}, {
	dev = { path = "~/dev/nvim-plugins/" },
	change_detection = { notify = false },
})
