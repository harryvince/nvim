local M = {}

function M.svelteFix()
	local clients = vim.lsp.get_active_clients()
	for _, found_client in ipairs(clients) do
		if found_client.name == "svelte" then
			vim.cmd("LspRestart " .. found_client.id)
			break
		end
	end
end

function M.TransparentBackground()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

function M.is_personal()
	return vim.uv.os_gethostname() == "HV-MBP.local"
end

return M
