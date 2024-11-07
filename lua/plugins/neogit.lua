return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
	},
    event = "VeryLazy",
	config = function ()
        local neogit = require('neogit')

        vim.keymap.set("n", "<leader>gs", neogit.open, {})
	end
}
