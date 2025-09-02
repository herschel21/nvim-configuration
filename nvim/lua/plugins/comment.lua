return {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
        require("Comment").setup({
            -- Add comment string support for JSX/TSX
            pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        })

        -- Better keymaps
        local opts = { noremap = true, silent = true }
        
        -- Normal mode - toggle current line
        vim.keymap.set("n", "<C-/>", function()
            require("Comment.api").toggle.linewise.current()
        end, opts)
        
        -- Visual mode - toggle selected lines
        vim.keymap.set("v", "<C-/>", function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<ESC>', true, false, true), 'nx', false)
            require("Comment.api").toggle.linewise(vim.fn.visualmode())
        end, opts)
        
        -- Alternative keymaps (common shortcuts)
        vim.keymap.set("n", "gcc", function()
            require("Comment.api").toggle.linewise.current()
        end, opts)
        
        vim.keymap.set("v", "gc", function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<ESC>', true, false, true), 'nx', false)
            require("Comment.api").toggle.linewise(vim.fn.visualmode())
        end, opts)
    end,
}

