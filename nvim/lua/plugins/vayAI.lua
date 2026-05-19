-- return {
--     dir = '~/workspace/work/vayavya/neovim_plugins/VayAI.nvim/',  -- Local path
--     config = function()
--         require('vayai').setup()
--     end
-- }

return {
    "harshel721/VayAI.nvim",
    -- event = "VeryLazy",
    event = false,
    cond = function()
        return vim.env.LLM_API_KEY ~= nil
    end,
    config = function()
        require('vayai').setup()
    end
}
