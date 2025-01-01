return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		local utils = require("conform.util")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier", stop_after_first = true },
				typescript = { "prettier", stop_after_first = true },
				yaml = { "prettier" },
				jsonls = { "prettier" },
				sh = { "shfmt" },
			},
			formatters = {
				prettier = { cwd = utils.root_file(".prettierrc") },
				biome = { cwd = utils.root_file("biome.json") },
				deno = { cwd = utils.root_file("deno.json") },
			},
		})

		vim.keymap.set("n", "<leader>ff", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			}, function(_, did_edit)
				if did_edit then
					vim.notify("File formatted.", vim.log.levels.INFO)
				else
					vim.notify("No changes were made during formatting.", vim.log.levels.WARN)
				end
			end)
		end)
	end,
}
