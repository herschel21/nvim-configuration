return {
    "tpope/vim-fugitive",
    cmd = {
        "G",
        "Git",
        "Gdiffsplit",
        "Gread",
        "Gwrite",
        "Ggrep",
        "GMove",
        "GDelete",
        "GBrowse",
        "GRemove",
        "GRename",
        "Glgrep",
        "Gedit"
    },
    ft = { "fugitive" },
    keys = {
        -- Core git operations
        { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
        { "<leader>ga", "<cmd>Git add .<cr>", desc = "Git add all" },
        { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
        { "<leader>gca", "<cmd>Git commit --amend<cr>", desc = "Git commit amend" },
        { "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
        { "<leader>gpf", "<cmd>Git push --force-with-lease<cr>", desc = "Git push force (safe)" },
        { "<leader>gl", "<cmd>Git pull<cr>", desc = "Git pull" },
        
        -- Git diff and blame
        { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff split" },
        { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
        
        -- Git log
        { "<leader>glg", "<cmd>Git log --oneline<cr>", desc = "Git log" },
        { "<leader>gll", "<cmd>Git log<cr>", desc = "Git log detailed" },
    },
    config = function()
        -- Create augroup for fugitive
        local fugitive_group = vim.api.nvim_create_augroup("FugitiveSettings", { clear = true })
        
        -- Auto-close fugitive buffers when navigating away
        vim.api.nvim_create_autocmd("BufReadPost", {
            group = fugitive_group,
            pattern = "fugitive://*",
            callback = function()
                vim.opt_local.bufhidden = "delete"
            end,
        })
        
        -- Set up fugitive-specific keymaps in git status buffer
        vim.api.nvim_create_autocmd("FileType", {
            group = fugitive_group,
            pattern = "fugitive",
            callback = function()
                local bufmap = function(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = true, desc = desc })
                end
                
                -- Staging shortcuts
                bufmap("n", "<leader>p", "<cmd>Git push<cr>", "Push")
                bufmap("n", "<leader>P", "<cmd>Git pull<cr>", "Pull")
                bufmap("n", "<leader>f", "<cmd>Git push --force-with-lease<cr>", "Force push (safe)")
            end,
        })
    end,
}

