return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  -- dependencies = { "nvim-treesitter/nvim-treesitter-context" },
  config = function()
    require("nvim-treesitter").setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })
    require("nvim-treesitter")
      .install({
        "javascript",
        "typescript",
        "lua",
        "vim",
        "python",
        "json",
        "terraform",
        "yaml",
      })
      :wait(300000)
  end,
}
