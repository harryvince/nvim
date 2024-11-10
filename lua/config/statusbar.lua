local statusline_augroup = vim.api.nvim_create_augroup("gmr_statusline", { clear = true })

--- @param type string
--- @return integer
local function get_git_diff(type)
	local gsd = vim.b.gitsigns_status_dict
	if gsd and gsd[type] then
		return gsd[type]
	end

	return 0
end

--- @return string
local function mode()
	return string.format("%%#StatusLineMode# %s %%*", vim.api.nvim_get_mode().mode)
end

--- @return string
local function git_diff_added()
	local added = get_git_diff("added")
	if added > 0 then
		return string.format("%%#StatusLineGitDiffAdded#+%s%%*", added)
	end

	return ""
end

--- @return string
local function git_diff_changed()
	local changed = get_git_diff("changed")
	if changed > 0 then
		return string.format("%%#StatusLineGitDiffChanged#~%s%%*", changed)
	end

	return ""
end

--- @return string
local function git_diff_removed()
	local removed = get_git_diff("removed")
	if removed > 0 then
		return string.format("%%#StatusLineGitDiffRemoved#-%s%%*", removed)
	end

	return ""
end

--- @return string
local function git_branch_icon()
	return "%#StatusLineGitBranchIcon#%*"
end

--- @return string
local function git_branch()
	local branch = vim.b.gitsigns_head

	if branch == "" or branch == nil then
		return ""
	end

	return string.format("%%#StatusLineMedium#%s%%*", branch)
end

--- @return string
local function full_git()
	local full = ""
	local space = "%#StatusLineMedium# %*"

	local branch = git_branch()
	if branch ~= "" then
		local icon = git_branch_icon()
		full = full .. space .. icon .. space .. branch .. space
	end

	local added = git_diff_added()
	if added ~= "" then
		full = full .. added .. space
	end

	local changed = git_diff_changed()
	if changed ~= "" then
		full = full .. changed .. space
	end

	local removed = git_diff_removed()
	if removed ~= "" then
		full = full .. removed .. space
	end

	return full
end

--- @return string
local function file_percentage()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local lines = vim.api.nvim_buf_line_count(0)

	return string.format("%%#StatusLineMedium# %d%%%% %%*", math.ceil(current_line / lines * 100))
end

--- @return string
local function total_lines()
	local lines = vim.fn.line("$")
	return string.format("%%#StatusLineMedium#of %s %%*", lines)
end

--- @param hlgroup string
local function formatted_filetype(hlgroup)
	local filetype = vim.bo.filetype or vim.fn.expand("%:e", false)
	return string.format("%%#%s# %s %%*", hlgroup, filetype)
end

StatusLine = {}

---@diagnostic disable-next-line: duplicate-set-field
StatusLine.inactive = function()
	return table.concat({
		formatted_filetype("StatusLineMode"),
	})
end

local redeable_filetypes = {
	["qf"] = true,
	["help"] = true,
	["tsplayground"] = true,
}

-- Function to get the current search match number
local function search_status()
	if vim.v.hlsearch == 1 then
		local result = vim.fn.searchcount({ maxcount = 9999 })
		return string.format("[%d/%d]", result.current, result.total)
	end
	return ""
end

--- @return string
local function recording_status()
	local reg_recording = vim.fn.reg_recording()
	if reg_recording ~= "" then
		return string.format("%%#StatusLineRecording# REC [%s] %%*", reg_recording)
	end
	return ""
end

---@diagnostic disable-next-line: duplicate-set-field
StatusLine.active = function()
	local mode_str = vim.api.nvim_get_mode().mode
	if mode_str == "t" or mode_str == "nt" then
		return table.concat({
			mode(),
			recording_status(),
			"%=",
			"%=",
			"%S ",
			"%c ",
			search_status(),
			file_percentage(),
			total_lines(),
		})
	end

	if redeable_filetypes[vim.bo.filetype] or vim.o.modifiable == false then
		return table.concat({
			formatted_filetype("StatusLineMode"),
			recording_status(),
			"%=",
			"%=",
			"%S ",
			"%c ",
			search_status(),
			file_percentage(),
			total_lines(),
		})
	end

	local statusline = {
		mode(),
		recording_status(),
		full_git(),
		"%=",
		"%=",
		"%S ",
		"%c ",
		search_status(),
		file_percentage(),
		total_lines(),
	}

	return table.concat(statusline)
end

vim.opt.statusline = "%!v:lua.StatusLine.active()"

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "FileType" }, {
	group = statusline_augroup,
	pattern = {
		"NvimTree_1",
		"NvimTree",
		"TelescopePrompt",
		"fzf",
		"lspinfo",
		"lazy",
		"netrw",
		"mason",
		"noice",
		"qf",
	},
	callback = function()
		vim.opt_local.statusline = "%!v:lua.StatusLine.inactive()"
	end,
})
