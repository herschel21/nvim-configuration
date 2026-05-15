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

		local api = require("Comment.api")
		local opts = { noremap = true, silent = true }

		vim.keymap.set("n", "gcc", api.toggle.linewise.current, opts)
		vim.keymap.set("v", "gc", function()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)
			api.toggle.linewise(vim.fn.visualmode())
		end, opts)

		vim.keymap.set("n", "gbc", api.toggle.blockwise.current, opts)
		vim.keymap.set("v", "gb", function()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)
			api.toggle.blockwise(vim.fn.visualmode())
		end, opts)
	end,
}
