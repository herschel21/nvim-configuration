return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	config = function()
		local bg_transparent = false

		local function apply(transparent)
			require("catppuccin").setup({
				transparent_background = transparent,
				flavour = "mocha",
				background = { light = "latte", dark = "mocha" },
				show_end_of_buffer = false,
				term_colors = false,
				dim_inactive = { enabled = false, shade = "dark", percentage = 0.15 },
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				integrations = {
					cmp = true,
					gitsigns = true,
					neotree = true,
					treesitter = true,
					lualine = true,
					notify = false,
					mini = { enabled = true, indentscope_color = "" },
					-- Additional integrations for installed plugins
					telescope = { enabled = true, style = "nvchad" },
					arial = true,
					indent_blankline = { enabled = true, scope_color = "lavender", colored_indent_levels = false },
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
						},
						inlay_hints = { background = true },
					},
					masonfloat = false,
					alpha = true,
				},
			})
			vim.cmd.colorscheme("catppuccin")
			-- Refresh lualine so its highlights update (catppuccin-mocha theme reads
			-- transparent_background from catppuccin.options, so a simple refresh suffices)
			if package.loaded["lualine"] then
				require("lualine").refresh()
			end
		end

		apply(bg_transparent)

		vim.keymap.set("n", "<leader>z", function()
			bg_transparent = not bg_transparent
			apply(bg_transparent)
		end, { desc = "Toggle transparent background", noremap = true, silent = true })
	end,
}
