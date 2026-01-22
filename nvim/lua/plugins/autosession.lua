return {
	"rmagatti/auto-session",
	lazy = false,
	keys = {
		{ "<leader>wr", "<cmd>SessionSearch<cr>", desc = "Session search" },
		{ "<leader>ws", "<cmd>SessionSave<cr>", desc = "Save session" },
		{ "<leader>wa", "<cmd>SessionToggleAutoSave<cr>", desc = "Toggle autosave" },
		{ "<leader>wd", "<cmd>SessionDelete<cr>", desc = "Delete session" },
	},
	opts = {
		-- Session management
		enabled = true,
		auto_save = false,
		auto_restore = true,
		auto_create = true,

		-- Simple session naming
		session_lens = {
			load_on_setup = true,
		},

		-- Directory handling
		suppressed_dirs = {
			"~/",
			"~/Downloads",
			"/",
		},

		-- File type filtering
		bypass_session_save_file_types = {
			"alpha",
			"dashboard",
			"neo-tree",
			"neo-tree-popup",
			"notify",
		},

		-- Simple hooks - just close neo-tree before saving
		pre_save_cmds = {
			"Neotree close",
		},

		post_restore_cmds = {
			function()
				-- Refresh lualine after restore
				if package.loaded.lualine then
					require("lualine").refresh()
				end
			end,
		},

		-- Cleanup
		close_unsupported_windows = true,

		-- Logging
		log_level = "error",
	},
}
