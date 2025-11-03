return {
    "nvim-neorg/neorg",
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- Add treesitter as dependency
    lazy = false, -- Disable lazy loading as it can break Neorg
    version = "*", -- Pin to latest stable release
    build = ":Neorg sync-parsers", -- Automatically install parsers after plugin installation
    config = function()
        require("neorg").setup({
            load = {
                ["core.defaults"] = {}, -- Loads default behaviour
                ["core.concealer"] = { -- Adds pretty icons to your documents
                    config = {
                        icon_preset = "diamond", -- Options: "basic", "diamond", "varied"
                    },
                },
                ["core.dirman"] = { -- Manages Neorg workspaces
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
                        engine = "nvim-cmp", -- Integrates with nvim-cmp for completion
                    },
                },
                ["core.export"] = {}, -- Export to other formats (markdown, etc)
                ["core.export.markdown"] = {}, -- Markdown export support
                ["core.summary"] = {}, -- Generate summaries
                ["core.tangle"] = {}, -- Extract code blocks
                ["core.ui.calendar"] = {}, -- Calendar integration
                ["core.journal"] = { -- Daily journal support
                    config = {
                        strategy = "flat", -- or "nested"
                    },
                },
                ["core.keybinds"] = {
                    config = {
                        default_keybinds = true, -- Enable default keybinds
                        neorg_leader = "<LocalLeader>", -- LocalLeader for Neorg commands
                    },
                },
            },
        })

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

