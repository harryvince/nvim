return {
  "yochem/jq-playground.nvim",
  config = function()
    vim.keymap.set("n", "<C-q>", function()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
          local name = vim.api.nvim_buf_get_name(buf)
          if name:match("jq output") or name:match("yq output") or name:match("query editor") then
            -- Force close the buffer
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end
      end
    end, { noremap = true, silent = true, desc = "Close jq playground buffers" })
  end,
}
