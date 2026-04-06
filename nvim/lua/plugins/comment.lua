return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		local comment = require("Comment")
		local ok, ts_integration = pcall(require, "ts_context_commentstring.integrations.comment_nvim")

		comment.setup({
			pre_hook = function(ctx)
				local ft = vim.bo.filetype

				-- Force single-line style for C/C++
				if ft == "c" or ft == "cpp" or ft == "h" or ft == "hpp" then
					return "// %s"
				end

				if ok then
					return ts_integration.create_pre_hook()(ctx)
				end
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

		-- Ensure commentstring is correct for C/C++ buffers
		vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
			pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
			callback = function()
				vim.bo.commentstring = "// %s"
			end,
		})

		-- Visual mode comment helpers (Comment.nvim doesn't handle <Esc> + mode automatically)
		local api = require("Comment.api")
		local opts = { noremap = true, silent = true }

		vim.keymap.set("v", "gc", function()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)
			api.toggle.linewise(vim.fn.visualmode())
		end, opts)

		vim.keymap.set("v", "gb", function()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)
			api.toggle.blockwise(vim.fn.visualmode())
		end, opts)
	end,
}
