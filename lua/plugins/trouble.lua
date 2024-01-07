return {
    "folke/trouble.nvim",
    event = 'VeryLazy',
    config = function ()
        local trouble = require("trouble")

        vim.keymap.set("n", "<C-l>", function ()
            trouble.toggle("workspace_diagnostics")
        end)
    end
}
