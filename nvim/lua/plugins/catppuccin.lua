return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		local state_file = vim.fn.stdpath("state") .. "/theme_transparent"

		local function read_transparent()
			local f = io.open(state_file, "r")
			if not f then
				return false
			end
			local content = f:read("*a")
			f:close()
			return content:match("1") ~= nil
		end

		local function write_transparent(value)
			local f = io.open(state_file, "w")
			if f then
				f:write(value and "1" or "0")
				f:close()
			end
		end

		local transparent = read_transparent()

		local function apply(is_transparent)
			-- exposed so plugins.lualine can build a transparency-aware theme too
			vim.g.theme_transparent = is_transparent

			require("catppuccin").setup({
				flavour = "mocha",
				background = { light = "latte", dark = "mocha" },
				transparent_background = is_transparent,
				show_end_of_buffer = false,
				term_colors = true,
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
				},
				integrations = {
					indent_blankline = { scope_color = "lavender" },
				},
			})
			vim.cmd.colorscheme("catppuccin")

			if package.loaded["lualine"] then
				require("plugins.lualine").setup_theme(is_transparent)
			end
			if package.loaded["bufferline"] then
				require("plugins.bufferline").setup_theme(is_transparent)
			end
		end

		apply(transparent)

		vim.keymap.set("n", "<leader>z", function()
			transparent = not transparent
			apply(transparent)
			write_transparent(transparent)
			vim.notify("Transparent background " .. (transparent and "enabled" or "disabled"), vim.log.levels.INFO)
		end, { desc = "Toggle transparent background", noremap = true, silent = true })
	end,
}
