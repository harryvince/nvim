function LspStatus()
	local clients = vim.lsp.get_clients()
	local buf_clients = {}

	for _, client in ipairs(clients) do
		if client.attached_buffers[vim.api.nvim_get_current_buf()] then
			table.insert(buf_clients, client.name)
		end
	end

	if #buf_clients == 0 then
		return "None"
	end

	return table.concat(buf_clients, ", ")
end

function FormatterStatus()
	local conform = require("conform")
	local bufnr = vim.api.nvim_get_current_buf()
	local formatters, _ = conform.list_formatters_to_run(bufnr)

	if #formatters > 0 then
		local formatter_names = {}
		for _, formatter in ipairs(formatters) do
			table.insert(formatter_names, formatter.name)
		end
        return table.concat(formatter_names, ", ")
    else
        return "None"
	end
end

vim.o.statusline = "%f" -- File name
	.. " %m" -- Modified flag
	.. " %r" -- Read-only flag
	.. " %y" -- File type
	.. " %= " -- Right-aligned section
	.. "LSP: %{v:lua.LspStatus()} " -- Custom LSP function
	.. "FMT: %{v:lua.FormatterStatus()} |" -- Custom LSP function
	.. " %p%%" -- Percentage through the file
	.. " %l:%c" -- Line and column