local ignoreFiles = { "netrw", "scratch" }
local ignoreFilesLSP = {}
local ignoreFilesFMT = { "go" }

vim.list_extend(ignoreFilesLSP, ignoreFiles)
vim.list_extend(ignoreFilesFMT, ignoreFiles)

function LspStatus()
	for _, file in ipairs(ignoreFilesLSP) do
		if vim.bo.filetype == file then
			return nil
		end
	end

	local clients = vim.lsp.get_clients()
	local buf_clients = {}

	for _, client in ipairs(clients) do
		if client.attached_buffers[vim.api.nvim_get_current_buf()] then
			table.insert(buf_clients, client.name)
		end
	end

	if #buf_clients == 0 then
		return "LSP: None"
	end

	return "LSP: " .. table.concat(buf_clients, ", ")
end

function FormatterStatus()
	for _, file in ipairs(ignoreFilesFMT) do
		if vim.bo.filetype == file then
			return nil
		end
	end

	local conform = require("conform")
	local bufnr = vim.api.nvim_get_current_buf()
	local formatters, _ = conform.list_formatters_to_run(bufnr)

	if #formatters > 0 then
		local formatter_names = {}
		for _, formatter in ipairs(formatters) do
			table.insert(formatter_names, formatter.name)
		end
		return "FMT: " .. table.concat(formatter_names, ", ")
	else
		return "FMT: None"
	end
end

function Display()
    local lsp = LspStatus()
    local formatter = FormatterStatus()

    if lsp == nil and formatter then
        return formatter
    elseif formatter == nil and lsp then
        return lsp
    elseif formatter == nil and lsp == nil then
        return ""
    else
        return lsp .. " " .. formatter
    end
end

vim.o.statusline = "%f" -- File name
	.. " %m" -- Modified flag
	.. " %r" -- Read-only flag
	-- .. " %y" -- File type
	.. " %= " -- Right-aligned section
	.. "%{v:lua.Display()}" -- Custom Display function
	.. " | %p%%" -- Percentage through the file
	.. " %l:%c" -- Line and column
