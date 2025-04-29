-- Additional plugins for Neovim, optimized for speed with lazy.nvim
-- Location: ~/.config/nvim/lua/plugins/additional_plugins.lua

return {
  -- Zen-mode.nvim: Distraction-free mode
  {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    keys = {
      { '<leader>zm', '<cmd>ZenMode<cr>', desc = 'Toggle Zen Mode' },
    },
    config = function()
      require('zen-mode').setup({
        window = {
          width = 120,
          options = {
            signcolumn = 'no',
            number = false,
            relativenumber = false,
            cursorline = false,
          },
        },
      })
    end,
  },
}
