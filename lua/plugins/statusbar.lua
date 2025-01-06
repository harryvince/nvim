return {
	"harryvince/statusbar.nvim",
	dependencies = {
		"stevearc/conform.nvim",
	},
	opts = {
		ignoreFiles = {
			fmt = { "go", "terraform" },
		},
	},
}
