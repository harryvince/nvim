return {
	"supermaven-inc/supermaven-nvim",
	cond = function()
		return vim.uv.os_gethostname() == "HV-MBP.local"
	end,
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<S-Tab>",
			},
		})
	end,
}
