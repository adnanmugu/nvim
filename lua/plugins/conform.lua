return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {},
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				css = { "prettier" },
				scss = { "prettier" },
				html = { "prettier" },
				javascript = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				lua = { "stylua" },
				markdown = { "prettier" },
				php = { "prettier" },
				python = { "black" },
			},
			format_on_save = {
				lsp_fallback = true,
				lsp_format = "fallback",
				async = false,
				timeout_ms = 500,
			},
			formatters = {
				stylua = {
					-- prepend_args = { "--column-width", "80" },
				},
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>sf", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
