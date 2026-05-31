return {
  {
    "kdheepak/lazygit.nvim",
    config = function()
      vim.keymap.set("n", "<leader>lg", function()
        --  get file name with extension
        local file = vim.fn.expand("%:t")
        vim.cmd("LazyGit")

        -- Wait a bit for LazyGit to load
        vim.defer_fn(function()
          -- search for the file, highlight, and exit search mode in lazygit
          vim.api.nvim_feedkeys("/" .. file, "t", true)
          vim.api.nvim_input("<CR>")
          vim.api.nvim_input("<ESC>")
        end, 150) -- (milliseconds)
      end, { desc = "[g]it" })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)

            return "<Ignore>"
          end, { expr = true })

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          -- Actions
          map("n", "<leader>gs", gs.toggle_signs)
          map("n", "<leader>tb", gs.toggle_current_line_blame)
          map("n", "<leader>td", gs.toggle_deleted)
        end,
      })

      -- Make the background of gitsigns transparent
      vim.cmd("highlight GitSignsAdd guibg=NONE")
      vim.cmd("highlight GitSignsChange guibg=NONE")
      vim.cmd("highlight GitSignsDelete guibg=NONE")
    end,
  },
}
