return {
	"frankroeder/parrot.nvim",
	dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim" },
	cond = function()
		return vim.uv.os_gethostname() == "HV-MBP.local"
	end,
	config = function()
		require("parrot").setup({
			-- Providers must be explicitly added to make them available.
			providers = {
				anthropic = {
					api_key = os.getenv("ANTHROPIC_API_KEY"),
				},
			},
		})
	end,
}
