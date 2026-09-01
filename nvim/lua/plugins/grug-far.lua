return {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    keys = {
        { "<leader>sR", "<cmd>GrugFar<cr>", desc = "[S]earch and [R]eplace (GrugFar)" },
    },
    config = function()
        require("grug-far").setup({})
    end,
}
