require("core.options")
require("core.keymaps")

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
require("lazy").setup({
	require("plugins.neotree"),
	require("plugins.colortheme"),
	require("plugins.bufferline"),
	require("plugins.lsp"),
	require("plugins.lualine"),
	require("plugins.telescope"),
	require("plugins.autocompletion"),
	require("plugins.autoformatting"),
	require("plugins.alpha"),
	require("plugins.indent-blankline"),
	require("plugins.comment"),
	require("plugins.noice"),
	require("plugins.lazy_dev"),
	require("plugins.nvim-comp"),
})
-- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
