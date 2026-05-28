return {
  {
    "datsfilipe/vesper.nvim",
    dev = false,
    enabled = true,
    config = function()
      require("vesper").setup({
        italics = {
          keywords = false,
          functions = false,
          strings = false,
          variables = false,
        },
      })
      vim.cmd.colorscheme("vesper")
      vim.cmd("highlight NormalFloat guibg=NONE")
      vim.opt.fillchars = { eob = " " }
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    enabled = false,
    config = function()
      require("rose-pine").setup({ styles = { bold = false, italic = false } })
      vim.cmd("colorscheme rose-pine")
    end,
  },
}
