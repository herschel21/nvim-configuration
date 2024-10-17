return {
	"akinsho/toggleterm.nvim",
	config = function()
		local toggleterm = require("toggleterm")
		toggleterm.setup({
			size = 13,
			open_mapping = [[<c-\>]],
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = "1",
			start_in_insert = true,
			persist_size = true,
			direction = "horizontal",
		})

		-- Key mappings
		vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap(
			"n",
			"<leader>ts",
			"<cmd>ToggleTermSendCurrentLine<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"v",
			"<leader>ts",
			"<cmd>ToggleTermSendVisualSelection<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap("n", "<leader>tn", "<cmd>ToggleTermSetName<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>ta", "<cmd>ToggleTermToggleAll<CR>", { noremap = true, silent = true })

		-- Function to send visual lines
		vim.api.nvim_set_keymap("v", "<leader>tl", ":lua SendVisualLines()<CR>", { noremap = true, silent = true })

		function SendVisualLines()
			vim.cmd("ToggleTermSendVisualLines")
		end
	end,
}
