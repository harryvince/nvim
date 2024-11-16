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

-- Formatting
set("n", "<leader>ff", function()
	vim.lsp.buf.format({ async = true })
end)

-- Focus window
set("n", "<leader>oo", "<cmd>only<CR>")

-- LSP Keymaps
set("n", "gd", vim.lsp.buf.definition)
set("n", "K", vim.lsp.buf.hover)
set("n", "<leader>vws", vim.lsp.buf.workspace_symbol)
set("n", "<leader>vd", vim.diagnostic.open_float)
set("n", "]d", vim.diagnostic.goto_next)
set("n", "[d", vim.diagnostic.goto_prev)
set("n", "<leader>rr", vim.lsp.buf.references)
set("n", "<leader>rn", vim.lsp.buf.rename)
set("i", "<C-h>", vim.lsp.buf.signature_help)

set("n", "<leader>zm", "<cmd>ZenMode<CR>")

-- Git keymaps
set("n", "<leader>gfh", "<cmd>DiffviewFileHistory %<CR>")

-- Move tabs easier
set("n", "<left>", "gT")
set("n", "<right>", "gt")
