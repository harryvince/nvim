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

function M.SetupClipboard()
	if vim.fn.has("wsl") == 1 then
		vim.g.clipboard = {
			name = "wsl clipboard",
			copy = { ["+"] = { "/mnt/c/Windows/System32/clip.exe" }, ["*"] = { "/mnt/c/Windows/System32/clip.exe" } },
			paste = { ["+"] = { "nvim_paste" }, ["*"] = { "nvim_paste" } },
			cache_enabled = true,
		}
	end
end

function M.TransparentBackground()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return M
