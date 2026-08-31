return {
	"nvim-tree/nvim-tree.lua",
	-- Must load eagerly (not on keys) so its BufEnter/BufNewFile autocmd is
	-- registered before the initial `nvim <dir>` buffer is opened, otherwise
	-- the directory-hijack (auto-open) never fires on startup.
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle nvim-tree" },
		{ "\\", "<cmd>NvimTreeFindFile<cr>", desc = "Reveal current file in nvim-tree" },
	},
	init = function()
		-- Disable netrw before it can initialize
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
	end,
	config = function()
		require("nvim-tree").setup({
			sort = {
				sorter = "case_sensitive",
			},
			view = {
				width = 35,
			},
			renderer = {
				group_empty = true,
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "",
							arrow_open = "",
						},
					},
				},
			},
			filters = {
				dotfiles = true,
				git_ignored = true,
				custom = { "node_modules", "\\.DS_Store$", "thumbs\\.db$" },
			},
			git = {
				enable = true,
			},
			diagnostics = {
				enable = true,
			},
			update_focused_file = {
				enable = true,
			},
			actions = {
				open_file = {
					window_picker = {
						enable = true,
					},
				},
			},
		})
	end,
}
