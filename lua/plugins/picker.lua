return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	---@module "fzf-lua"
	---@type fzf-lua.Config|{}
	---@diagnostics disable: missing-fields
	opts = {},
	config = function()
		local fzf = require("fzf-lua")
		vim.keymap.set("n", "<leader>pf", function()
			fzf.files({ winopts = { preview = { hidden = true } } })
		end, { desc = "Find files" })
		vim.keymap.set("n", "<leader>bf", fzf.buffers, { desc = "Find open buffers" })
		vim.keymap.set("n", "<leader>ps", fzf.live_grep, { desc = "Run live grep" })
		vim.keymap.set("n", "<leader>/", function()
    ---@diagnostic disable-next-line: missing-fields
			fzf.lgrep_curbuf({ winopts = { preview = { hidden = true } } })
		end, { desc = "Search in current buffer" })
		vim.keymap.set("n", "<leader>sp", fzf.spell_suggest, { desc = "Find spelling suggestions" })
	end,
}
