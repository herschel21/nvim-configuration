return {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
        local comment = require("Comment")
        local api = require("Comment.api")
        local ts_integration = require("ts_context_commentstring.integrations.comment_nvim")

        comment.setup({
            pre_hook = ts_integration.create_pre_hook(),
        })

        local opts = { noremap = true, silent = true }

        -- Linewise comment toggles
        vim.keymap.set("n", "<leader>c", api.toggle.linewise.current, opts)
        vim.keymap.set("n", "gcc", api.toggle.linewise.current, opts)

        vim.keymap.set("v", "<leader>c", function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "nx", false)
            api.toggle.linewise(vim.fn.visualmode())
        end, opts)
        vim.keymap.set("v", "gc", function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "nx", false)
            api.toggle.linewise(vim.fn.visualmode())
        end, opts)

        -- Blockwise comment toggles
        vim.keymap.set("n", "<leader>b", api.toggle.blockwise.current, opts)
        vim.keymap.set("n", "gbc", api.toggle.blockwise.current, opts)

        vim.keymap.set("v", "<leader>b", function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "nx", false)
            api.toggle.blockwise(vim.fn.visualmode())
        end, opts)
        vim.keymap.set("v", "gb", function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "nx", false)
            api.toggle.blockwise(vim.fn.visualmode())
        end, opts)
    end,
}

