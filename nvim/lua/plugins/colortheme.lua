-- return {
-- 	"shaunsingh/nord.nvim",
-- 	--"williamboman/mason.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		-- Example config in lua
-- 		vim.g.nord_contrast = true
-- 		vim.g.nord_borders = false
-- 		vim.g.nord_disable_background = true
-- 		vim.g.nord_italic = false
-- 		vim.g.nord_uniform_diff_background = true
-- 		vim.g.nord_bold = false
--
-- 		-- Load the colorscheme
-- 		require("nord").set()
--
-- 		local bg_transparent = true
--
-- 		local toggle_transparency = function()
-- 			bg_transparent = not bg_transparent
-- 			vim.g.nord_disable_background = bg_transparent
-- 			vim.cmd([[colorscheme nord]])
-- 		end
--
-- 		vim.keymap.set("n", "<leader>z", toggle_transparency, { noremap = true, silent = true })
-- 	end,
-- }
return {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        -- Enable true color support
        vim.opt.termguicolors = true

        -- Theme configuration
        vim.g.zenbones = {
            -- Darkness preset for dark mode: 'stark', 'default', or 'warm'
            darkness = default,
            -- Lightness preset for light mode: 'bright', 'default', or 'dim'
            lightness = default,
            -- Darken the background of comments (0-100)
            darken_comments = 45,
            -- Settings for background
            transparent_background = false,
            -- Italicize comments
            italic_comments = true,
            -- Enable diagnostic underline coloring
            colorize_diagnostic_underline_text = true,
        }

        -- Function to toggle background
        local function toggle_background()
            if vim.o.background == 'light' then
                vim.o.background = 'dark'
            else
                vim.o.background = 'light'
            end
            vim.cmd.colorscheme('zenbones')
        end

        -- Set up keymapping for background toggle
        vim.keymap.set("n", "<leader>zb", toggle_background, 
            { noremap = true, silent = true, desc = "Toggle background light/dark" })

        -- Set initial colorscheme
        vim.cmd.colorscheme('zenbones')
    end,
}
