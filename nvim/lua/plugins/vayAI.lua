-- return {
--     dir = '~/workspace/work/vayavya/neovim_plugins/VayAI.nvim/',  -- Local path
--     config = function()
--         require('vayai').setup()
--     end
-- }

return {
    "harshel721/VayAI.nvim",
    config = function()
        require('vayai').setup()
    end
}
