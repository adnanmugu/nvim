return {
	"saghen/blink.cmp",
	enabled = true,
	lazy = true,
	dependencies = "rafamadriz/friendly-snippets",
	version = "*",
	opts = {
		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
			kind_icons = require("lib.icons").kind,
		},
		completion = {
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
			ghost_text = {
				enabled = true,
			},
		},
		signature = {
			enabled = true,
		},
		keymap = {
			preset = "none",
			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },
			["<C-y>"] = { "accept", "fallback" },

			["<C-space>"] = {
				function(cmp)
					cmp.show({ providers = { "snippets" } })
				end,
			},
		},
		sources = {
			default = { "lsp", "path", "snippets", "lazydev", "buffer" },
			providers = {
				lsp = {
					min_keyword_length = 0,
					score_offset = 0,
				},
				path = {
					min_keyword_length = 0,
					opts = {
						trailing_slash = true,
						label_trailing_slash = true,
						get_cwd = function(context)
							return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
						end,
						show_hidden_files_by_default = true,
					},
				},
				snippets = {
					min_keyword_length = 0,
				},
				buffer = {
					min_keyword_length = 2,
					max_items = 5,
				},
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
			},
		},
		cmdline = {
			keymap = {
				["<C-n>"] = {
					function(cmp)
						if cmp.is_ghost_text_visible() and not cmp.is_menu_visible() then
							return cmp.accept()
						end
					end,
					"show_and_insert",
					"select_next",
				},
				["<C-p>"] = { "show_and_insert", "select_prev" },
				["<CR>"] = { "accept_and_enter", "fallback" },
			},
			completion = {
				list = {
					selection = {
						preselect = false,
						auto_insert = true,
					},
				},
				menu = {
					auto_show = true,
				},
				ghost_text = { enabled = true },
			},
		},
	},
	opts_extend = { "sources.default" },
}
