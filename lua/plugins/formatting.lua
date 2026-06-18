return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    local function get_formatter(bufnr)
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      local dirname = bufname ~= "" and vim.fs.dirname(bufname) or vim.uv.cwd()

      if vim.fs.root(dirname, "biome.json") then
        return { "biome" }
      else
        return { "oxfmt", "prettier", stop_after_first = true }
      end
    end

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = get_formatter,
        typescript = get_formatter,
        typescriptreact = get_formatter,
        javascriptreact = get_formatter,
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
