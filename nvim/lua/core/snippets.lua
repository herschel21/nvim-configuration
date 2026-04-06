-- Misc autocmds and editor behaviour tweaks

-- Prevent LSP from overwriting treesitter colour settings
-- https://github.com/NvChad/NvChad/issues/1907
vim.hl.priorities.semantic_tokens = 95

-- Diagnostic appearance
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		format = function(diagnostic)
			local code = diagnostic.code and string.format("[%s]", diagnostic.code) or ""
			return string.format("%s %s", code, diagnostic.message)
		end,
	},
	underline = false,
	update_in_insert = true,
	float = {
		source = "always",
	},
	on_ready = function()
		vim.cmd("highlight DiagnosticVirtualText guibg=NONE")
	end,
})

-- Highlight yanked text briefly
local yank_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Adjust kitty terminal padding when entering/leaving nvim
local kitty_group = vim.api.nvim_create_augroup("KittyPadding", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
	group = kitty_group,
	callback = function()
		vim.fn.system("kitty @ set-spacing padding=0 margin=0 3 0 3")
	end,
})
vim.api.nvim_create_autocmd("VimLeave", {
	group = kitty_group,
	callback = function()
		vim.fn.system("kitty @ set-spacing padding=default margin=default")
	end,
})
