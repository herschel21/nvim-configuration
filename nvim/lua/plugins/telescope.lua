return {
	"nvim-telescope/telescope.nvim",
	-- branch = "0.1.x", -- REMOVED to fix ft_to_lang error with recent nvim-treesitter
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>?", "<cmd>Telescope oldfiles<cr>", desc = "[?] Find recently opened files" },
		{ "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "[S]earch existing [B]uffers" },
		{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "[S]earch [M]arks" },
		{ "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "[S]earch [F]iles" },
		{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "[S]earch [H]elp" },
		{ "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "[S]earch current [W]ord" },
		{ "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "[S]earch by [G]rep" },
		{ "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "[S]earch [D]iagnostics" },
		{ "<leader>sr", "<cmd>Telescope resume<cr>", desc = "[S]earch [R]resume" },
		{ "<leader>s.", "<cmd>Telescope oldfiles<cr>", desc = "[S]earch Recent Files" },
		{ "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		{
			"<leader>s/",
			function()
				require("telescope.builtin").live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end,
			desc = "[S]earch [/] in Open Files",
		},
		{
			"<leader>/",
			function()
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end,
			desc = "[/] Fuzzily search in current buffer",
		},
	},
	config = function()
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")

		-- Custom select that forces cursor position AFTER all autocmds
		local function select_and_force_position(prompt_bufnr)
			local entry = action_state.get_selected_entry()

			-- Store the target position before selecting
			local target_line = entry and entry.lnum
			local target_col = entry and entry.col or 1

			actions.select_default(prompt_bufnr)

			-- Force the cursor position AFTER BufReadPost runs
			if target_line then
				vim.schedule(function()
					vim.schedule(function() -- Double schedule to run after ALL autocmds
						pcall(vim.api.nvim_win_set_cursor, 0, { target_line, target_col - 1 })
						vim.cmd("normal! zz") -- Center the line
					end)
				end)
			end
		end

		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<C-n>"] = actions.move_selection_next,
						["<C-p>"] = actions.move_selection_previous,
						["<Down>"] = actions.move_selection_next,
						["<Up>"] = actions.move_selection_previous,
						["<CR>"] = select_and_force_position,
						["<C-x>"] = actions.select_horizontal,
						["<C-v>"] = actions.select_vertical,
						["<C-t>"] = actions.select_tab,
						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					},
					n = {
						["<Esc>"] = actions.close,
						["q"] = actions.close,
						["<CR>"] = select_and_force_position,
					},
				},
				prompt_prefix = " ",
				selection_caret = " ",
				path_display = { "truncate" },
				file_ignore_patterns = { ".git/", "node_modules" },
				dynamic_preview_title = true,
				results_title = false,
			},
			pickers = {
				find_files = {
					file_ignore_patterns = { "node_modules", ".git", ".venv", "*.pyc" },
					hidden = true,
					follow = true,
				},
				live_grep = {
					additional_args = function()
						return { "--hidden" }
					end,
					file_ignore_patterns = { "node_modules", ".git", ".venv", "*.min.js" },
				},
				buffers = {
					ignore_current_buffer = true,
					sort_lastused = true,
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		-- Enable telescope extensions
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
	end,
}
