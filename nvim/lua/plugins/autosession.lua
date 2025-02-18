return {
  'rmagatti/auto-session',
  lazy = false, -- We want this to load right away
  opts = {
    log_level = "error",
    auto_session_enable_last_session = false,
    auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
    auto_session_enabled = true,
    auto_save_enabled = true,
    auto_restore_enabled = true,
    auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
    
    -- Recommended sessionoptions configuration
    auto_session_create_enabled = true,
    session_lens = {
      -- Will load Telescope if available
      load_on_setup = true,
      theme_conf = { border = true },
      previewer = false,
    },
    
    bypass_save_filetypes = { "alpha", "NvimTree" },     
    -- Useful hooks
    pre_save_cmds = {
      function()
        -- Close nvim-tree before saving session
        local nvim_tree = require('nvim-tree.api')
        nvim_tree.tree.close()
      end
    },
    
    post_restore_cmds = {
      function()
        -- Restore nvim-tree if it was open
        local nvim_tree = require('nvim-tree.api')
        nvim_tree.tree.open()
      end
    },
  },
  keys = {
    { "<leader>wr", "<cmd>SessionRestore<CR>", desc = "Restore session for current dir" },
    { "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save session for current dir" },
    { "<leader>wd", "<cmd>SessionDelete<CR>", desc = "Delete session for current dir" },
    { "<leader>wf", "<cmd>SessionSearch<CR>", desc = "Search sessions" },
  },
}
