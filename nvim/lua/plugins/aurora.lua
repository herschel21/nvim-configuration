return {
	"ray-x/aurora",
	lazy = false,
	name = "aurora",
	priority = 1000,
	config = function()
		local bg_transparent = false

		local function apply(transparent)
			vim.g.aurora_italic = 1
			vim.g.aurora_bold = 1
			vim.g.aurora_darker = 1
			vim.g.aurora_transparent = transparent and 1 or 0
			vim.cmd.colorscheme("aurora")
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
