-- [[ Core Configuration ]]
-- mapleader must be set before lazy.nvim so plugin key specs resolve correctly
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.options")

-- [[ Bootstrap lazy.nvim ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- [[ Plugin Groups ]]
local plugins = {
	-- UI and Theming
	{ import = "plugins.aurora" }, -- Theme

	{ import = "plugins.lualine" }, -- Status line
	{ import = "plugins.indent-blankline" },
	{ import = "plugins.alpha" },
	{ import = "plugins.autosession" },
	{ import = "plugins.treesitter" },
	{ import = "plugins.vayAI" },
	{ import = "plugins.latex-nvim" },
	{ import = "plugins.markdown-preview" },

	-- Editor Features
	{ import = "plugins.neotree" }, -- File explorer
	{ import = "plugins.telescope" }, -- Fuzzy finder
	{ import = "plugins.aerial" }, -- Code outline
	{ import = "plugins.autopairs" }, -- Auto brackets
	{ import = "plugins.comment" }, -- Comments
	{ import = "plugins.fugitive" },
	{ import = "plugins.gitsigns" },
	-- { import = "plugins.vimtex" },

	-- Development Tools
	{ import = "plugins.lsp" }, -- Language Server Protocol
	{ import = "plugins.mason" }, -- Language Server Protocol
	{ import = "plugins.autocompletion" },
	{ import = "plugins.codium" }, -- AI completion

	-- Utilities
	{ import = "plugins.lazy_dev" },
	{ import = "plugins.bufdelete" },
}

-- [[ Lazy.nvim Configuration ]]
local ok, err = pcall(function()
	require("lazy").setup(plugins, {
		install = {
			colorscheme = { "aurora" },
		},
		ui = {
			icons = vim.g.have_nerd_font and {} or {
				cmd = "⌘",
				config = "🛠",
				event = "📅",
				ft = "📂",
				init = "⚙",
				keys = "🗝",
				plugin = "🔌",
				runtime = "💻",
				require = "🌙",
				source = "📄",
				start = "🚀",
				task = "📌",
				lazy = "💤 ",
			},
		},
		change_detection = {
			enabled = true,
			notify = false,
		},
		performance = {
			cache = {
				enabled = true,
			},
			reset_packpath = true,
			rtp = {
				reset = true,
				disabled_plugins = {
					"gzip",
					"matchit",
					"matchparen",
					"netrwPlugin",
					"tarPlugin",
					"tohtml",
					"tutor",
					"zipPlugin",
				},
			},
		},
	})
end)

if not ok then
	vim.notify("Error loading lazy.nvim: " .. tostring(err), vim.log.levels.ERROR)
end

-- Defer diagnostic config, autocmds and keymaps until after the UI is ready.
-- vim.diagnostic and all keymap tables are heavy; deferring saves ~4ms from startup.
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	once = true,
	callback = function()
		require("core.snippets")
		require("core.keymaps")
	end,
})

