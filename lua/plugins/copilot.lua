return {
	"github/copilot.vim",
	enabled = false,
	cond = function()
		return vim.uv.os_gethostname() == "HV-MBP.local"
	end,
}
