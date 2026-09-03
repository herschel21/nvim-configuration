-- Custom code snippets for different purposes

-- Prevent LSP from overwriting treesitter color settings
-- https://github.com/NvChad/NvChad/issues/1907
vim.hl.priorities.semantic_tokens = 95

-- Appearance of diagnostics
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		format = function(diagnostic)
			local code = diagnostic.code and string.format("[%s]", diagnostic.code) or ""
			return string.format("%s %s", code, diagnostic.message)
		end,
	},
	underline = false,
	update_in_insert = false,
	float = {
		source = "always",
	},
})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Set kitty terminal padding to 0 when in nvim (only inside kitty itself)
if vim.env.KITTY_WINDOW_ID then
	local kitty_group = vim.api.nvim_create_augroup("kitty_mp", { clear = true })
	vim.api.nvim_create_autocmd("VimLeave", {
		group = kitty_group,
		callback = function()
			vim.fn.system("kitty @ set-spacing padding=default margin=default")
		end,
	})
	vim.api.nvim_create_autocmd("VimEnter", {
		group = kitty_group,
		callback = function()
			vim.fn.jobstart("kitty @ set-spacing padding=0 margin=0 3 0 3")
		end,
	})
end
