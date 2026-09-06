return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "oxfmt" },
        typescript = { "oxfmt" },
        typescriptreact = { "oxfmt" },
        javascriptreact = { "oxfmt" },
        yaml = { "oxfmt" },
        toml = { "oxfmt" },
        json = { "oxfmt" },
        markdown = { "oxfmt" },
        sh = { "shfmt" },
        py = { "ruff" },
        go = { "gofmt" },
      },
      format_on_save = function()
        if vim.g.formatOnSave == true then
          return {
            lsp_format = "fallback",
            quiet = true,
            timeout_ms = 1000,
          }
        end
      end,
    })

    vim.keymap.set("n", "<leader>ff", function()
      vim.g.formatOnSave = not vim.g.formatOnSave
      print("Format on save => " .. tostring(vim.g.formatOnSave))
    end)
  end,
}
