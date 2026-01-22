return {
    "nvim-neorg/neorg",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" }, -- plenary is also required
    lazy = false, -- Neorg needs to load early to register parsers
    version = "*",
    build = ":Neorg sync-parsers",
    config = function()
        require("neorg").setup({
            load = {
                ["core.defaults"] = {}, -- Loads all the default modules
                ["core.concealer"] = { -- Pretty icons and concealing
                    config = {
                        icon_preset = "diamond",
                    },
                },
                ["core.dirman"] = { -- Workspace manager
                    config = {
                        workspaces = {
                            notes = "~/workspace/work/vayavya/neorg",
                            work = "~/workspace/work/vayavya/neorg/work",
                            personal = "~/workspace/work/vayavya/neorg/personal",
                        },
                        default_workspace = "notes",
                    },
                },
                ["core.completion"] = {
                    config = {
                        engine = "nvim-cmp",
                    },
                },
                ["core.export"] = {},
                ["core.export.markdown"] = {},

                -- Optional but recommended newer modules:
                ["core.integrations.treesitter"] = {}, -- ensures full Treesitter integration
                ["core.integrations.nvim-cmp"] = {}, -- explicit nvim-cmp integration

                ["core.summary"] = {},
                ["core.tangle"] = {},
                ["core.ui.calendar"] = {},
                ["core.journal"] = {
                    config = {
                        strategy = "flat",
                        workspace = "personal", -- optional: place journals in specific workspace
                    },
                },
                ["core.keybinds"] = {
                    config = {
                        default_keybinds = true,
                        neorg_leader = "<LocalLeader>",
                    },
                },
            },
        })

        -- Keymaps
        local keymap = vim.keymap.set
        local opts = { noremap = true, silent = true }

        keymap("n", "<Leader>ni", "<cmd>Neorg index<CR>", vim.tbl_extend("force", opts, { desc = "Neorg: Open index" }))
        keymap("n", "<Leader>nr", "<cmd>Neorg return<CR>", vim.tbl_extend("force", opts, { desc = "Neorg: Return to previous buffer" }))
        keymap("n", "<Leader>nw", "<cmd>Neorg workspace<CR>", vim.tbl_extend("force", opts, { desc = "Neorg: Select workspace" }))

        keymap("n", "<Leader>nj", "<cmd>Neorg journal today<CR>", vim.tbl_extend("force", opts, { desc = "Neorg: Today's journal" }))
        keymap("n", "<Leader>ny", "<cmd>Neorg journal yesterday<CR>", vim.tbl_extend("force", opts, { desc = "Neorg: Yesterday's journal" }))
        keymap("n", "<Leader>nt", "<cmd>Neorg journal tomorrow<CR>", vim.tbl_extend("force", opts, { desc = "Neorg: Tomorrow's journal" }))

        keymap("n", "<Leader>nc", "<cmd>Neorg toc<CR>", vim.tbl_extend("force", opts, { desc = "Neorg: Table of contents" }))
        keymap("n", "<Leader>ne", "<cmd>Neorg export to-file<CR>", vim.tbl_extend("force", opts, { desc = "Neorg: Export to file" }))
    end,
}

