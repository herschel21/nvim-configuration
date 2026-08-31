local M = {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
}

-- Builds the lualine theme straight from catppuccin's palette instead of using
-- catppuccin's own "catppuccin-mocha" lualine theme: that theme is baked once
-- at first `require` and cached by Lua's module system, so it never picks up
-- a later transparency toggle. Computing it ourselves keeps it reactive, and
-- also lets plugins.catppuccin call this again after <leader>z.
local function build_theme(transparent)
	local C = require("catppuccin.palettes").get_palette("mocha")
	local bg = transparent and "NONE" or C.mantle

	return {
		normal = {
			a = { bg = C.blue, fg = C.mantle, gui = "bold" },
			b = { bg = C.surface0, fg = C.blue },
			c = { bg = bg, fg = C.text },
		},
		insert = {
			a = { bg = C.green, fg = C.mantle, gui = "bold" },
			b = { bg = C.surface0, fg = C.green },
		},
		visual = {
			a = { bg = C.mauve, fg = C.mantle, gui = "bold" },
			b = { bg = C.surface0, fg = C.mauve },
		},
		replace = {
			a = { bg = C.red, fg = C.mantle, gui = "bold" },
			b = { bg = C.surface0, fg = C.red },
		},
		command = {
			a = { bg = C.peach, fg = C.mantle, gui = "bold" },
			b = { bg = C.surface0, fg = C.peach },
		},
		inactive = {
			a = { bg = bg, fg = C.blue },
			b = { bg = bg, fg = C.surface1 },
			c = { bg = bg, fg = C.overlay0 },
		},
	}
end

function M.setup_theme(transparent)
	local C = require("catppuccin.palettes").get_palette("mocha")

	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = build_theme(transparent),
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
			disabled_filetypes = { statusline = { "alpha", "neo-tree" } },
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
			lualine_b = { "branch" },
			lualine_c = {
				{ "filename", file_status = true, path = 0 },
				{
					"diff",
					symbols = { added = " ", modified = " ", removed = " " },
					diff_color = {
						added = { fg = C.green },
						modified = { fg = C.yellow },
						removed = { fg = C.red },
					},
				},
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
		extensions = { "fugitive", "neo-tree", "lazy", "mason" },
	})
end

M.config = function()
	M.setup_theme(vim.g.theme_transparent)

	-- Go to buffer by number (bufferline shows the matching ordinal on each tab)
	for i = 1, 9 do
		vim.keymap.set("n", "<leader>" .. i, function()
			local buffers = vim.fn.getbufinfo({ buflisted = 1 })
			if buffers[i] then
				vim.api.nvim_set_current_buf(buffers[i].bufnr)
			end
		end, { desc = "Go to Buffer " .. i })
	end
end

return M
