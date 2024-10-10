-- nvim-notify.lua

return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	config = function()
		local notify = require("notify")

		-- Set up notify
		notify.setup({
			-- Animation style (see :help notify-config-stages)
			stages = "fade_in_slide_out",

			-- Default timeout for notifications
			timeout = 5000,

			-- For stages that change opacity, this is treated as the highlight behind the window
			background_colour = "#000000",
		})

		-- Set notify as the default notification handler
		vim.notify = notify

		-- Utility functions
		local function notify_output(command, opts)
			local output = vim.api.nvim_exec(command, true)
			vim.notify(output, "info", opts)
		end

		-- Some example keymaps for quick access
		vim.keymap.set("n", "<leader>nd", function()
			notify_output("Notifications", { title = "Notification List" })
		end, { desc = "Show Notification List" })

		vim.keymap.set("n", "<leader>nc", notify.dismiss, { desc = "Clear Notifications" })

		-- Optional: Set up Telescope integration
		require("telescope").load_extension("notify")
		vim.keymap.set("n", "<leader>ns", function()
			require("telescope").extensions.notify.notify()
		end, { desc = "Search Notifications" })
	end,
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
}
