return {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim", -- richer diff views inside Neogit
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        -- Core git operations
        { "<leader>gs", "<cmd>Neogit<cr>", desc = "Git status" },
        { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Git commit (popup, press 'a' to amend)" },
        { "<leader>gp", "<cmd>Neogit push<cr>", desc = "Git push (popup)" },
        { "<leader>gl", "<cmd>Neogit pull<cr>", desc = "Git pull (popup)" },
        { "<leader>gb", "<cmd>Neogit branch<cr>", desc = "Git branch (popup)" },

        -- Git log
        { "<leader>glg", "<cmd>Neogit log<cr>", desc = "Git log (popup)" },

        -- Not exposed as a Neogit popup: shell out directly
        { "<leader>grf", "<cmd>split | terminal git reflog<cr>", desc = "Git reflog" },
        {
            "<leader>gdd",
            "<cmd>split | terminal git push -f --push-option=target=qnx-dut53<cr>",
            desc = "Git push to dut-1",
        },
    },
    config = function()
        require("neogit").setup({})
    end,
}
