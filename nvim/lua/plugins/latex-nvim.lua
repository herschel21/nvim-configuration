return {
    "herschel21/tex.nvim",
    ft = {"tex", "latex"},
    config = function()
        require("latex-nvim").setup({
            compile_script    = "compile_latex",
            viewer            = "evince",
            compile_on_save   = true,
            auto_open_pdf     = true,
            quickfix_mode     = false,  -- ← no quickfix window popping up
            output_win_height = 0,      -- ← no output split
        })    end,
}
