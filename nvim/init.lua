-- [[ Core Configuration ]]
require("core.options")
require("core.snippets")
require("core.keymaps")

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
	{ import = "plugins.catpuccin" },
	{ import = "plugins.lualine" },
	{ import = "plugins.indent-blankline" },
	{ import = "plugins.alpha" },
	{ import = "plugins.autosession" },
	{ import = "plugins.treesitter" },
	{ import = "plugins.neorg" },
	{ import = "plugins.vayAI" },
	{ import = "plugins.latex-nvim" },

	-- Editor Features
	{ import = "plugins.neotree" },
	{ import = "plugins.telescope" },
	{ import = "plugins.aerial" },
	{ import = "plugins.autopairs" },
	{ import = "plugins.comment" },
	{ import = "plugins.fugitive" },
	-- { import = "plugins.conform" },
	{ import = "plugins.gitsigns" },
	-- { import = "plugins.vimtex" },

	-- Development Tools
	{ import = "plugins.lsp" },
	{ import = "plugins.mason" },
	{ import = "plugins.autocompletion" },
	-- { import = "plugins.codium" },

	-- Utilities
	{ import = "plugins.lazy_dev" },
}

-- [[ Lazy.nvim Configuration ]]
local ok, err = pcall(function()
	require("lazy").setup(plugins, {
		install = {
			colorscheme = { "catppuccin" },
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
