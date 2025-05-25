return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
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
			lsp_format = "fallback",
			async = false,
			timeout_ms = 500,
		},
		formatters = {
			stylua = {
				-- prepend_args = { "--column-width", "80" },
			},
		},
	},
}
