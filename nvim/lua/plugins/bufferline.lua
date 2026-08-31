local M = {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.setup_theme(transparent)
	-- catppuccin.special.bufferline captures `catppuccin.options` at require
	-- time, so a stale cached module would keep showing the pre-toggle
	-- transparency; force it to re-require and pick up what we just set via
	-- plugins.catppuccin's apply(). Same gotcha handled in plugins.lualine.
	package.loaded["catppuccin.special.bufferline"] = nil

	require("bufferline").setup({
		options = {
			mode = "buffers",
			numbers = "ordinal", -- matches the buflisted-index used by <leader>1-9 in plugins.lualine
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, _, diagnostics_dict)
				local result = ""
				for kind, n in pairs(diagnostics_dict) do
					local icon = kind == "error" and " " or (kind == "warning" and " " or "")
					result = result .. n .. icon
				end
				return result
			end,
			offsets = {
				{
					filetype = "neo-tree",
					text = "File Explorer",
					highlight = "Directory",
					text_align = "left",
					separator = true,
				},
			},
			separator_style = "thin",
			show_buffer_close_icons = true,
			show_close_icon = false,
			always_show_bufferline = true,
			close_command = function(n) require("bufdelete").bufdelete(n, false) end,
			right_mouse_command = function(n) require("bufdelete").bufdelete(n, false) end,
		},
		highlights = require("catppuccin.special.bufferline").get_theme(),
	})
end

M.config = function()
	M.setup_theme(vim.g.theme_transparent)
end

return M
