return {
	"github/copilot.vim",
	cond = function()
		return vim.uv.os_gethostname() == "HV-MBP.local"
	end,
}
