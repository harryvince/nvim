return {
	"saghen/blink.cmp",
	dependencies = "rafamadriz/friendly-snippets",
	version = "v0.*",
	opts = {
		keymap = { preset = "default" },

		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},

		signature = { enabled = true },

		sources = {
			providers = {
				path = {
					opts = {
						show_hidden_files_by_default = true,
					},
				},
			},
		},

		completion = {
			menu = {
				auto_show = function(ctx)
					return ctx.mode ~= "cmdline"
				end,
			},
		},
	},
}
