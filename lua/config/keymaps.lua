local set = vim.keymap.set

vim.g.mapleader = " "
set("n", "<leader>pv", vim.cmd.Ex)

set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

set("n", "J", "mzJ`z")
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")
set("n", "<C-q>", ":q <CR>")

-- why is this not here by default ;(
set("x", ">", ">gv", { noremap = true, silent = true })
set("x", "<", "<gv", { noremap = true, silent = true })

-- zz but for horizontal
set("n", "zs", ":normal! zszH<CR>")

set({ "n", "v", "x" }, "<leader>y", '"+y')
set({ "n", "v", "x" }, "<leader>d", '"+d')

set("n", "Q", "<nop>")
set("n", "-", "<nop>")

set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- LSP Reset
set("i", "<C-c>", "<Esc>")

-- Focus window
set("n", "<leader>oo", "<cmd>only<CR>")

-- Prety neat this like
vim.keymap.set("n", "<leader>w", function()
	if vim.wo.wrap then
		vim.wo.wrap = false
		print("Wrap: OFF")
	else
		vim.wo.wrap = true
		print("Wrap: ON")
	end
end, { desc = "Toggle line wrap" })
