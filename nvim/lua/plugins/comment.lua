return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },

	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},

	config = function()
		local comment = require("Comment")

		comment.setup({
			pre_hook = function(ctx)
				local ft = vim.bo.filetype

				-- Force // comments for C/C++ (prevents /* */ default)
				if ft == "c" or ft == "cpp" or ft == "h" or ft == "hpp" then
					return "// %s"
				end

				local ok, ts_integration = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
				if ok then
					local ret = ts_integration.create_pre_hook()(ctx)
					if ret then
						return ret
					end
				end

				return vim.bo.commentstring
			end,

			toggler = {
				line = "gcc",
				block = "gbc",
			},
			opleader = {
				line = "gc",
				block = "gb",
			},

			ignore = "^$",
		})

		-- Ensure C/C++ commentstring stays correct after filetype detection
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "c", "cpp" },
			callback = function()
				vim.bo.commentstring = "// %s"
			end,
		})

	end,
}
