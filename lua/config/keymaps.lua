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

-- zz but for horizontal
set("n", "zs", ":normal! zszH<CR>")

-- greatest remap ever
set("x", "<leader>p", '"_dP')

-- next greatest remap ever : asbjornHaland
set("n", "<leader>y", '"+y')
set("v", "<leader>y", '"+y')
set("n", "<leader>Y", '"+Y')

set("n", "<leader>d", '"_d')
set("v", "<leader>d", '"_d')

set("n", "Q", "<nop>")
set("n", "-", "<nop>")

set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- LSP Reset
set("i", "<C-c>", "<Esc>")

-- Focus window
set("n", "<leader>oo", "<cmd>only<CR>")

set("n", "<leader>zm", "<cmd>ZenMode<CR>")

-- Git keymaps
set("n", "<leader>gfh", "<cmd>DiffviewFileHistory %<CR>")

-- Move tabs easier
set("n", "<right>", "gt")
