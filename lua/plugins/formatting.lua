return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        py = { "ruff" },
        go = { "gofmt" },
      },
      format_on_save = function(bufnr)
        if vim.g.formatOnSave == true then
          return {
            lsp_format = "fallback",
            quiet = true,
            timeout_ms = 1000,
            filter = function(client)
              if
                vim.tbl_contains({
                  "javascript",
                  "javascriptreact",
                  "typescript",
                  "typescriptreact",
                  "json",
                  "jsonc",
                  "yaml",
                  "toml",
                  "markdown",
                }, vim.bo[bufnr].filetype)
              then
                return client.name == "oxfmt"
              end

              return true
            end,
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
