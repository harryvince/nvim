local winbar_filetype_exclude = {
    'help',
    'startify',
    'dashboard',
    'packer',
    'neogitstatus',
    'NvimTree',
    'Trouble',
    'trouble',
    'alpha',
    'lir',
    'Outline',
    'spectre_panel',
    'toggleterm',
    'DressingSelect',
    'Jaq',
    'harpoon',
    'lab',
    'Markdown',
    'fzf',
    'dap-float',
    'dap-repl',
}

local function get_filename()
    local filename = vim.fn.expand '%:.'
    local utils = require("config.utils")

    if not utils.is_nil_or_empty_string(filename) then
        local readonly = ''
        if vim.bo.readonly then
            readonly = ' '
        end

        return string.format(
            ' %%##%%*%%#WarningMsg#%s%%* %%#WinBar#%s%%*',
            readonly,
            filename
        )
    end
end

local function excludes()
    if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
        vim.opt_local.winbar = nil
        return true
    end

    return false
end

local function get_winbar()
    if excludes() then
        return
    end

    local utils = require("config.utils")
    local value = get_filename()

    if not utils.is_nil_or_empty_string(value) and utils.is_unsaved() then
        local mod = '%#WarningMsg#*%*'
        value = value .. mod
    end

    local num_tabs = #vim.api.nvim_list_tabpages()

    if num_tabs > 1 and not utils.is_nil_or_empty_string(value) then
        local tabpage_number = tostring(vim.api.nvim_tabpage_get_number(0))
        value = value .. '%=' .. tabpage_number .. '/' .. tostring(num_tabs)
    end

    local status_ok, _ = pcall(
        vim.api.nvim_set_option_value,
        'winbar',
        value,
        { scope = 'local' }
    )

    if not status_ok then
        return
    end
end

vim.api.nvim_create_autocmd({
    'CursorMoved',
    'CursorHold',
    'BufWinEnter',
    'BufFilePost',
    'InsertEnter',
    'BufWritePost',
    'TabClosed',
}, {
    group = vim.api.nvim_create_augroup('gmr_winbar', { clear = true }),
    callback = function()
        local status_ok, _ =
            pcall(vim.api.nvim_buf_get_var, 0, 'lsp_floating_window')
        if not status_ok then
            get_winbar()
        end
    end,
})
