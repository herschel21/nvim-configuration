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

        local opts = { noremap = true, silent = true }

        -- Single line comment/uncomment
        vim.keymap.set("n", "<leader>c", require("Comment.api").toggle.linewise.current, opts)

        -- Multi-line comment/uncomment in visual mode
        vim.keymap.set("v", "<leader>c", function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<ESC>', true, false, true), 'nx', false)
            require("Comment.api").toggle.linewise(vim.fn.visualmode())
        end, opts)

        -- Classic gc motion for object-aware commenting
        vim.keymap.set("n", "gcc", require("Comment.api").toggle.linewise.current, opts)
        vim.keymap.set("v", "gc", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)
    end,
}

