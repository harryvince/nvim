return {
    "folke/trouble.nvim",
    config = function ()
        local trouble = require("trouble")

        vim.keymap.set("n", "<leader>tt", function ()
            trouble.toggle("workspace_diagnostics")
        end)
    end
}
