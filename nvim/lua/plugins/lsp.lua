return {
	"neovim/nvim-lspconfig",
	ft = { "c", "cpp", "lua" },
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{
			"j-hui/fidget.nvim",
			opts = {
				notification = {
					window = {
						winblend = 0,
						border = "rounded",
					},
				},
			},
		},
	},
	config = function()
		-- Diagnostics UI (Neovim's LSP defaults cover keymaps like grn/gra/grr/gri/grt/gO/K/i_CTRL-S,
		-- so we only add what those don't: diagnostic navigation/float and workspace symbols below).
		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = true },
			virtual_text = { prefix = "●" },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.INFO] = "",
					[vim.diagnostic.severity.HINT] = "",
				},
			},
		})

		-- Filter non-file buffers (fugitive://, git://, etc.)
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("skip-non-file-lsp", { clear = true }),
			callback = function(event)
				local uri = vim.uri_from_bufnr(event.buf)
				if not uri:match("^file://") then
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client then
						vim.schedule(function()
							vim.lsp.stop_client(client.id)
						end)
					end
				end
			end,
		})

		-- LSP keymaps and features
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Navigation
				map("gd", function() require("telescope.builtin").lsp_definitions() end, "[G]oto [D]efinition")
				map("gr", function() require("telescope.builtin").lsp_references() end, "[G]oto [R]eferences")
				map("gI", function() require("telescope.builtin").lsp_implementations() end, "[G]oto [I]mplementation")
				map("<leader>D", function() require("telescope.builtin").lsp_type_definitions() end, "Type [D]efinition")
				map("<leader>ds", function() require("telescope.builtin").lsp_document_symbols() end, "[D]ocument [S]ymbols")
				map("<leader>ws", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end, "[W]orkspace [S]ymbols")

				-- Diagnostics
				map("<leader>e", vim.diagnostic.open_float, "Show Diagnostic [E]rror")
				map("[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Previous Diagnostic")
				map("]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next Diagnostic")

				-- Actions
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				-- Highlight symbol under cursor
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.documentHighlightProvider then
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.clear_references,
					})
				end

				-- Inlay hints toggle
				if client and client.server_capabilities.inlayHintProvider then
					map("<leader>th", function()
						local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
						vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = event.buf })
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		-- Capabilities
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		-- Server configurations
		local servers = {
			clangd = {
				cmd = {
					"clangd",
					"--offset-encoding=utf-16",
					"--pch-storage=memory", -- keep preambles in RAM instead of disk -> much faster completion
				},
			},
			lua_ls = {
				settings = {
					Lua = {
						completion = { callSnippet = "Replace" },
						diagnostics = { disable = { "missing-fields" } },
					},
				},
			},
		}

		-- Apply per-server config via the native vim.lsp.config API.
		-- mason-lspconfig v2 dropped `handlers`/`setup_handlers`; servers are now
		-- enabled automatically (automatic_enable, on by default) once installed,
		-- picking up whatever was passed to vim.lsp.config() here.
		for name, server in pairs(servers) do
			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
			vim.lsp.config(name, server)
		end

		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_keys(servers),
		})
	end,
}
