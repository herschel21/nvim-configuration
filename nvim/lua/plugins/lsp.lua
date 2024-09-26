return {
	{
		"neovim/nvim-lspconfig", -- LSP configurations
		config = function()
			local lspconfig = require("lspconfig")

			local on_attach = function(client, bufnr)
				local function buf_set_keymap(...)
					vim.api.nvim_buf_set_keymap(bufnr, ...)
				end

				-- Set omnifunc option
				vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

				local opts = { noremap = true, silent = true }
				buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
				buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
				buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
				buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
				buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

				if client.server_capabilities.documentFormattingProvider then
					vim.cmd([[augroup Format]])
					vim.cmd([[autocmd! * <buffer>]])
					vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
					vim.cmd([[augroup END]])
				end
			end

			-- Setup language servers
			local servers = { "pyright", "ts_ls", "lua_ls" } -- Note: "ts_ls" should be "ts_ls"

			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup({
					on_attach = on_attach,
					flags = {
						debounce_text_changes = 150,
					},
				})
			end
		end,
	},
}
