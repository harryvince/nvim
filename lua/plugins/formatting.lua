return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		local utils = require("conform.util")

		local function get_formatter()
			if utils.root_file({ "biome.json" }) then
				return { "biome" }
			elseif utils.root_file({ "deno.json" }) then
				return { "deno" }
			else
				return { "prettier" }
			end
		end

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = get_formatter(),
				typescript = get_formatter(),
				typescriptreact = get_formatter(),
				javascriptreact = get_formatter(),
				yaml = { "prettier" },
				jsonls = { "prettier" },
				markdown = { "prettier" },
				sh = { "shfmt" },
			},
			formatters = {
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
