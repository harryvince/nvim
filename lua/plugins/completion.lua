local source_mappings = {
  lsp = "[lsp]",
  buffer = "[buf]",
  snippets = "[snip]",
  path = "[path]",
}

return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets", "onsails/lspkind.nvim" },
    version = "v1.*",
    opts = {
      keymap = { preset = "default" },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },

      signature = { enabled = true },

      sources = {
        providers = {
          path = { opts = { show_hidden_files_by_default = true } },
        },
      },

      completion = {
        menu = {
          auto_show = function(ctx)
            return ctx.mode ~= "cmdline"
          end,
          draw = {
            padding = { 0, 1 },
            components = {
              kind_icon = {
                text = function(ctx)
                  return " " .. ctx.kind_icon .. ctx.icon_gap .. " "
                end,
              },
              source_name = {
                text = function(ctx) return source_mappings[ctx.source_name:lower()] end,
              },
            },
            columns = {
              { "label", "label_description" },
              { "kind_icon", "kind" },
              { "source_name" },
            },
          },
        },
      },
    },
  },
  {
    "supermaven-inc/supermaven-nvim",
    cond = require("config.utils").is_personal,
    opts = { keymaps = { accept_suggestion = "<S-Tab>" } },
  },
}
