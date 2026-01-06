local function map_providers()
  local providers = {
    lsp = {},
    buffer = {},
    snippets = {},
    path = { opts = { show_hidden_files_by_default = true } },
  }
  for name, provider in pairs(providers) do
    local extra_opts = {
      ---@diagnostic disable-next-line: unused-local
      transform_items = function(ctx, items)
        for _, item in ipairs(items) do
          item.kind_icon = "[" .. name .. "]"
        end
        return items
      end,
    }
    local provider_opts = vim.tbl_deep_extend("force", provider, extra_opts)
    providers[name] = provider_opts
  end
  return providers
end

return {
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "v1.*",
    opts = {
      keymap = { preset = "default" },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },

      signature = { enabled = true },

      sources = {
        providers = map_providers(),
      },

      completion = {
        menu = {
          auto_show = function(ctx)
            return ctx.mode ~= "cmdline"
          end,
          draw = { columns = {
          { "label", "label_description", gap = 1 },
          { "kind_icon" },
          } }
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
