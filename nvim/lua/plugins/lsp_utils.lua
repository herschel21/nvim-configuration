-- File: lua/plugins/lsp_utils.lua

local M = {}

M.go_to_implementation = function()
	local params = vim.lsp.util.make_position_params()

	vim.lsp.buf_request(0, "textDocument/implementation", params, function(err, result, ctx, config)
		if err then
			print("Error in textDocument/implementation:", vim.inspect(err))
			return
		end

		if not result or vim.tbl_isempty(result) then
			print("No implementation found")
			return
		end

		if vim.tbl_islist(result) then
			vim.lsp.util.jump_to_location(result[1], "utf-8")
		else
			vim.lsp.util.jump_to_location(result, "utf-8")
		end
	end)
end

return M
