return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "wincent/ferret",
  },
  config = function()
    local ts = require("telescope.builtin")
    require("telescope").setup({
      defaults = {
        results_title = false,
        layout_strategy = "vertical",
        layout_config = { height = 0.95 },
        file_ignore_patterns = {
          "node_modules",
          ".git/",
          ".venv/",
          ".terraform/",
        },
      },
      pickers = {
        find_files = { hidden = true, previewer = false },
        git_files = { previewer = false },
        current_buffer_fuzzy_find = { previewer = false },
        live_grep = { additional_args = { "--hidden" }, disable_devicons = true },
      },
      extensions = { fzf = {}, ["ui-select"] = {
        require("telescope.themes").get_dropdown({}),
      } },
    })
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")

    vim.keymap.set("n", "<leader>pf", ts.find_files, { desc = "Telescope find files" })
    vim.keymap.set("n", "<leader>pF", function()
      ts.find_files({ cwd = vim.fn.expand("%:p:h") })
    end, { desc = "Telescope find files (cwd)" })
    vim.keymap.set("n", "<C-p>", ts.git_files, { desc = "Telescope git files" })
    vim.keymap.set("n", "<leader>ps", ts.live_grep, { desc = "Telescope live grep" })
    vim.keymap.set("n", "<leader>pS", function()
      ts.live_grep({ cwd = vim.fn.expand("%:p:h") })
    end, { desc = "Telescope live grep" })
    vim.keymap.set("n", "<leader>/", ts.current_buffer_fuzzy_find, { desc = "Telescope current buffer fuzzy find" })
    vim.keymap.set("n", "<leader>bf", ts.buffers, { desc = "Telescope buffers" })
    vim.keymap.set("n", "<leader>sp", function()
      require("telescope.builtin").spell_suggest(require("telescope.themes").get_cursor({}))
    end, { desc = "Telescope spelling suggestions" })
    vim.keymap.set("n", "<leader>:", ts.command_history, { desc = "Telescope previous commands" })
  end,
}
