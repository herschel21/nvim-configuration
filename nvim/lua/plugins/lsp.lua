return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
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
				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				map("D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
				map("ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

				-- Actions
				map("rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
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
					map("th", function()
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
			clangd = { cmd = { "clangd", "--offset-encoding=utf-16" } },
			lua_ls = {
				settings = {
					Lua = {
						completion = { callSnippet = "Replace" },
						diagnostics = { disable = { "missing-fields" } },
					},
				},
			},
		}

		-- Setup servers
		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_keys(servers),
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
