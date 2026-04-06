return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"moll/vim-bbye",
	},
	config = function()
		-- Use Catppuccin's built-in lualine theme
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "catppuccin", -- Use theme directly, no custom colors
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				disabled_filetypes = { "alpha", "neo-tree" },
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
				lualine_a = {
					{
						"buffers",
						show_filename_only = true,
						hide_filename_extension = false,
						show_modified_status = true,
						mode = 0,
						max_length = vim.o.columns * 2 / 3,
						symbols = {
							modified = " ●",
							alternate_file = "#",
							directory = "",
						},
					},
				},
				lualine_z = { "tabs" },
			},
			extensions = { "fugitive", "neo-tree" },
		})

		-- Go to buffer by number
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
