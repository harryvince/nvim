function LspStatus()
	local clients = vim.lsp.get_clients()
	local buf_clients = {}

	for _, client in ipairs(clients) do
		if client.attached_buffers[vim.api.nvim_get_current_buf()] then
			table.insert(buf_clients, client.name)
		end
	end

	if #buf_clients == 0 then
		return "No LSP"
	end

	return table.concat(buf_clients, ", ")
end


vim.o.statusline = "%f" -- File name
	.. " %m" -- Modified flag
	.. " %r" -- Read-only flag
	.. " %y" -- File type
	.. " %= " -- Right-aligned section
	.. "LSP: %{v:lua.LspStatus()}" -- Custom LSP function
	.. " %p%%" -- Percentage through the file
	.. " %l:%c" -- Line and column
