return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- "catppuccin-mocha" is shipped by catppuccin itself under its plugin rtp;
		-- lualine resolves it automatically. Do NOT use pcall+require — the theme
		-- is a string name, not a Lua module path.
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "catppuccin-mocha",
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = { "alpha", "neo-tree" },
					tabline = { "alpha" }, -- hide bufferline on dashboard
				},
				always_divide_middle = true,
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return " " .. str
						end,
					},
				},
				lualine_b = { "branch", "diff" },
				lualine_c = {
					{ "filename", file_status = true, path = 0 },
				},
				lualine_x = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
					},
					"encoding",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { { "location", padding = 0 } },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {
				lualine_a = {}, -- keep empty: lualine_a's bold accent color is for mode, not buffers
				lualine_c = {
					{
						"buffers",
						show_filename_only = true,
						hide_filename_extension = false,
						show_modified_status = true,
						mode = 2, -- show buffer number + name (makes <leader>1-9 jumps predictable)
						max_length = function() return vim.o.columns * 2 / 3 end, -- dynamic: updates on resize
						buffers_color = {
							-- catppuccin mocha "blue"; only fg is given so lualine still
							-- fills in the theme's own (mode/transparency-aware) background.
							active = { fg = "#89b4fa" },
						},
						filetype_names = {
							TelescopePrompt = "Telescope",
							["neo-tree"] = "Neo-Tree",
							alpha = "Dashboard",
							lazy = "Lazy",
							mason = "Mason",
						},
						symbols = {
							modified = " ●",
							alternate_file = "#",
							directory = "",
						},
					},
				},
				-- lualine_z intentionally empty: vim tabs are managed via keymaps (<leader>to/tn/tp/tx)
				-- not shown in the bar to keep the tabline clean
			},
			extensions = { "fugitive" },
		})

		-- Go to buffer by number (Keeping this as it's specifically for 1-9 navigation)
		for i = 1, 9 do
			vim.keymap.set("n", "<leader>" .. i, function()
				local buffers = vim.fn.getbufinfo({ buflisted = 1 })
				if buffers[i] then
					vim.api.nvim_set_current_buf(buffers[i].bufnr)
				end
			end, { desc = "Go to Buffer " .. i })
		end
	end,
}
