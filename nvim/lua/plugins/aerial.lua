return {
    "stevearc/aerial.nvim",
    cmd = { "AerialToggle", "AerialOpen", "AerialNavToggle" },
    keys = {
        { "<leader>o", "<cmd>AerialToggle!<cr>", desc = "Aerial Toggle" },
        { "<leader>on", "<cmd>AerialNavToggle<cr>", desc = "Aerial Nav Toggle" },
    },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("aerial").setup({
            on_attach = function(bufnr)
                vim.keymap.set("n", "{", "<cmd>AerialPrev<cr>", { buffer = bufnr, desc = "Previous symbol" })
                vim.keymap.set("n", "}", "<cmd>AerialNext<cr>", { buffer = bufnr, desc = "Next symbol" })
            end,
            layout = {
                min_width = 30,
                default_direction = "prefer_right",
                placement = "window",
            },
            show_guides = true,
            filter_kind = {
                "Class",
                "Constructor",
                "Enum",
                "Function",
                "Interface",
                "Module",
                "Method",
                "Struct",
            },
            -- Automatically open aerial when entering supported buffer
            open_automatic = function(bufnr)
                return vim.api.nvim_buf_line_count(bufnr) > 80
                    and aerial.num_symbols(bufnr) > 4
                    and not aerial.was_closed()
            end,
        })
    end,
}

