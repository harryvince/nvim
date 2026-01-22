return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local function formatting()
      if not vim.g.formatOnSave then
        return "󰷙"
      else
        return ""
      end
    end

    require("lualine").setup({
      options = {
        icons_enabled = false,
        theme = "auto",
        component_separators = "",
        section_separators = "",
      },
      sections = {
        lualine_a = { "" },
        lualine_b = { { "filename", path = 1 }, formatting },
        lualine_c = { "diagnostics" },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
