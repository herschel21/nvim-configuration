-- File: lua/plugins/lsp_utils.lua

local M = {}

M.go_to_implementation = function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		print("No LSP clients attached")
		return
	end
	
	local offset_encoding = clients[1].offset_encoding or 'utf-16'
	local params = vim.lsp.util.make_position_params(0, offset_encoding)

	vim.lsp.buf_request(0, "textDocument/implementation", params, function(err, result, ctx, config)
		if err then
			print("Error in textDocument/implementation:", vim.inspect(err))
			return
		end

		if not result or vim.tbl_isempty(result) then
			print("No implementation found")
			return
		end

		-- Use show_document with both focus=true and reuse_win=false
		if vim.islist(result) then
			vim.lsp.util.show_document(result[1], offset_encoding, { focus = true, reuse_win = false })
		else
			vim.lsp.util.show_document(result, offset_encoding, { focus = true, reuse_win = false })
		end
	end)
end

return M

