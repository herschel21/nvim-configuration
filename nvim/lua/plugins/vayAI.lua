-- return {
--     dir = '~/workspace/work/vayavya/neovim_plugins/VayAI.nvim/',  -- Local path
--     config = function()
--         require('vayai').setup()
--     end
-- }

return {
    "harshel721/VayAI.nvim",
    event = "VeryLazy",
    config = function()
        -- Only attempt setup if API key is present to avoid startup warnings
        if vim.env.LLM_API_KEY then
            require('vayai').setup()
        end
    end
}
