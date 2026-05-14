local filetypes = { "yaml", "terraform-vars" }

for _, ft in ipairs(filetypes) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = ft,
    callback = function()
      vim.treesitter.start()
    end,
  })
end
