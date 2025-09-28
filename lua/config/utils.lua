local M = {}

function M.TransparentBackground()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

function M.is_personal()
	return vim.uv.os_gethostname() == "HV-MBP.local"
end

return M
