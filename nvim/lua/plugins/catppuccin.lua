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
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end

		apply(bg_transparent)

		vim.keymap.set("n", "<leader>z", function()
			bg_transparent = not bg_transparent
			apply(bg_transparent)
		end, { noremap = true, silent = true })
	end,
}
