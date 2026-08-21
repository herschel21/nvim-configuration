return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signcolumn = true,
		numhl = false,
		linehl = false,
		word_diff = false,
		watch_gitdir = {
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame = false,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol",
			delay = 1000,
		},
		on_attach = function(bufnr)
			local gs = require("gitsigns")
			local opts = { buffer = bufnr, noremap = true, silent = true }

			-- Navigation
			vim.keymap.set("n", "]c", function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, vim.tbl_extend("force", opts, { expr = true, desc = "Next git hunk" }))

			vim.keymap.set("n", "[c", function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, vim.tbl_extend("force", opts, { expr = true, desc = "Previous git hunk" }))

			-- Actions
			vim.keymap.set("n", "<leader>hs", gs.stage_hunk, vim.tbl_extend("force", opts, { desc = "Stage hunk" }))
			vim.keymap.set("n", "<leader>hr", gs.reset_hunk, vim.tbl_extend("force", opts, { desc = "Reset hunk" }))
			vim.keymap.set(
				"n",
				"<leader>hu",
				gs.undo_stage_hunk,
				vim.tbl_extend("force", opts, { desc = "Undo stage hunk" })
			)
			vim.keymap.set("n", "<leader>hp", gs.preview_hunk, vim.tbl_extend("force", opts, { desc = "Preview hunk" }))
			vim.keymap.set("n", "<leader>hb", function()
				gs.blame_line({ full = true })
			end, vim.tbl_extend("force", opts, { desc = "Blame line" }))
			vim.keymap.set(
				"n",
				"<leader>tb",
				gs.toggle_current_line_blame,
				vim.tbl_extend("force", opts, { desc = "Toggle git blame" })
			)
			vim.keymap.set("n", "<leader>hd", gs.diffthis, vim.tbl_extend("force", opts, { desc = "Diff this" }))
		end,
	},
}
