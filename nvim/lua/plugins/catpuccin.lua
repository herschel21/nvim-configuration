return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        -- Declare the variable to track transparency state
        local bg_transparent = false

        -- Define the toggle transparency function
        local toggle_transparency = function()
            bg_transparent = not bg_transparent
            require("catppuccin").setup({
                transparent_background = bg_transparent,
                flavour = "mocha", -- Can be one of: latte, frappe, macchiato, mocha
                background = {
                    light = "latte",
                    dark = "mocha",
                },
                show_end_of_buffer = false,
                term_colors = false,
                dim_inactive = {
                    enabled = false,
                    shade = "dark",
                    percentage = 0.15,
                },
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
                    nvimtree = true,
                    treesitter = true,
                    notify = false,
                    mini = {
                        enabled = true,
                        indentscope_color = "",
                    },
                },
            })

            -- Reload colorscheme with new transparency setting
            vim.cmd.colorscheme "catppuccin"
        end

        -- Call the setup function to apply the theme
        require("catppuccin").setup({
            flavour = "mocha", -- Initial flavor
            background = {
                light = "latte",
                dark = "mocha",
            },
            transparent_background = false, -- Start with non-transparent background
            show_end_of_buffer = false,
            term_colors = false,
            dim_inactive = {
                enabled = false,
                shade = "dark",
                percentage = 0.15,
            },
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
                nvimtree = true,
                treesitter = true,
                notify = false,
                mini = {
                    enabled = true,
                    indentscope_color = "",
                },
            },
        })

        -- Set up the keymap to toggle transparency
        vim.keymap.set("n", "<leader>z", toggle_transparency, { noremap = true, silent = true })

        -- Load the initial colorscheme
        vim.cmd.colorscheme "catppuccin"
    end,
}

