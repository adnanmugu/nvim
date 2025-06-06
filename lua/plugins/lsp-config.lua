return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"saghen/blink.cmp",
		"stevearc/conform.nvim",
		"b0o/SchemaStore.nvim",
	},
	config = function()
		local capabilities = nil

		if pcall(require, "cmp_nvim_lsp") then
			capabilities = require("blink.cmp").get_lsp_capabilities()
		end

		local lspconfig = require("lspconfig")

		local servers = {
			bashls = true,
			lua_ls = {
				-- server_capabilities = {
				--   semanticTokensProvider = vim.NIL,
				-- },
			},

			pyright = true,
			ruff = { manual_install = true },

			ts_ls = {
				root_dir = require("lspconfig").util.root_pattern("package.json"),
				single_file = false,
				server_capabilities = {
					documentFormattingProvider = false,
				},
			},

			-- denols = true,
			jsonls = {
				server_capabilities = {
					documentFormattingProvider = false,
				},
				settings = {
					json = {
						-- schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			},

			cssls = {
				server_capabilities = {
					documentFormattingProvider = false,
				},
			},
		}

		local servers_to_install = vim.tbl_filter(function(key)
			local t = servers[key]
			if type(t) == "table" then
				return not t.manual_install
			else
				return t
			end
		end, vim.tbl_keys(servers))

		require("mason").setup()

		local ensure_installed = {
			"lua_ls",
			-- "tailwind-language-server",
		}

		vim.list_extend(ensure_installed, servers_to_install)
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		for name, config in pairs(servers) do
			if config == true then
				config = {}
			end
			config = vim.tbl_deep_extend("force", {}, {
				capabilities = capabilities,
			}, config)

			lspconfig[name].setup(config)
		end

		local disable_semantic_tokens = {
			-- lua = true,
		}

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local bufnr = args.buf
				local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

				local settings = servers[client.name]
				if type(settings) ~= "table" then
					settings = {}
				end

				local builtin = require("telescope.builtin")

				local key = vim.keymap
				vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
				key.set("n", "gd", builtin.lsp_definitions, {})
				key.set("n", "gr", builtin.lsp_references, {})
				key.set("n", "gD", vim.lsp.buf.declaration, {})
				key.set("n", "gT", vim.lsp.buf.type_definition, {})
				key.set("n", "K", vim.lsp.buf.hover, {})

				key.set("n", "<space>cr", vim.lsp.buf.rename, {})
				key.set("n", "<space>ca", vim.lsp.buf.code_action, {})
				key.set("n", "<space>wd", builtin.lsp_document_symbols, {})

				local filetype = vim.bo[bufnr].filetype
				if disable_semantic_tokens[filetype] then
					client.server_capabilities.semanticTokensProvider = nil
				end

				-- Override server capabilities
				if settings.server_capabilities then
					for k, v in pairs(settings.server_capabilities) do
						if v == vim.NIL then
							---@diagnostic disable-next-line: cast-local-type
							v = nil
						end

						client.server_capabilities[k] = v
					end
				end

				-- navic --
				local navic = require("nvim-navic")
				if client and client.server_capabilities.documentSymbolProvider then
					vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
					navic.attach(client, args.buf)
				end
			end,
		})

		require("plugins.conform")

		vim.diagnostic.config({
			virtual_text = {
				prefix = "", -- Could be '●', '▎', │, 'x', '■', , 
				spacing = 1,
			},
			jump = {
				float = true,
			},
			float = { border = "single" },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰌶 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
				numhl = {
					[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
					[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
					[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
					[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
				},
			},
		})
	end,
}
