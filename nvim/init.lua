-- [[ Core Configuration ]]
require("core.options")
require("core.snippets")
require("core.keymaps")

-- [[ Bootstrap lazy.nvim ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.uv).fs_stat(lazypath) then
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
	{ import = "plugins.catppuccin" }, -- Theme
	{ import = "plugins.lualine" }, -- Status line
	{ import = "plugins.indent-blankline" },
	{ import = "plugins.alpha" },
	{ import = "plugins.autosession" },
	{ import = "plugins.treesitter" },
	{ import = "plugins.vayAI" },
	{ import = "plugins.latex-nvim" },

	-- Editor Features
	{ import = "plugins.neotree" }, -- File explorer
	{ import = "plugins.telescope" }, -- Fuzzy finder
	{ import = "plugins.aerial" }, -- Code outline
	{ import = "plugins.autopairs" }, -- Auto brackets
	{ import = "plugins.comment" }, -- Comments
	{ import = "plugins.fugitive" },
	-- { import = "plugins.conform" },
	{ import = "plugins.gitsigns" },
	-- { import = "plugins.vimtex" },

	-- Development Tools
	{ import = "plugins.lsp" }, -- Language Server Protocol
	{ import = "plugins.mason" }, -- Language Server Protocol
	{ import = "plugins.autocompletion" },
	-- { import = "plugins.codium" }, -- AI completion

	-- Utilities
	{ import = "plugins.lazy_dev" },
	{ import = "plugins.bufdelete" },
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

-- [[ Session Management - Commented Out Template ]]
-- -- Set session directory (can be customized)
-- local session_dir = vim.fn.stdpath("data") .. "/sessions"
--
-- -- Ensure session directory exists
-- vim.fn.mkdir(session_dir, "p")
--
-- -- Load session if it exists (with a specific filename)
-- local function load_session()
--     local session_file = session_dir .. "/.session.vim"
--     if vim.fn.filereadable(session_file) == 1 then
--         vim.cmd("source " .. session_file)
--     end
-- end
--
-- -- Auto-save session on exit
-- vim.api.nvim_create_autocmd("VimLeavePre", {
--     callback = function()
--         local session_file = session_dir .. "/.session.vim"
--         vim.cmd("mksession! " .. session_file)
--     end,
-- })
--
-- -- Load session on startup if it exists
-- vim.api.nvim_create_autocmd("VimEnter", {
--     callback = function()
--         -- Only load session if nvim was started without arguments
--         if vim.fn.argc() == 0 then
--             load_session()
--         end
--     end,
-- })
