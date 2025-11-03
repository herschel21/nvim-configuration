return {
  "rmagatti/auto-session",
  lazy = false,
  keys = {
    { "<leader>wr", "<cmd>AutoSession search<CR>", desc = "Session search" },
    { "<leader>ws", "<cmd>AutoSession save<CR>", desc = "Save session" },
    { "<leader>wa", "<cmd>AutoSession toggle<CR>", desc = "Toggle autosave" },
    { "<leader>wd", "<cmd>AutoSession delete<CR>", desc = "Delete session" },
  },
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    -- Session management
    enabled = true,
    auto_save = false,
    auto_restore = true,
    auto_create = true,
    
    -- FIXED: Custom session name to avoid long paths
    session_name = function()
      local cwd = vim.fn.getcwd()
      local project_name = vim.fn.fnamemodify(cwd, ":t")
      local git_branch = ""
      local git_head = cwd .. "/.git/HEAD"
      if vim.fn.filereadable(git_head) == 1 then
        local branch_ref = vim.fn.readfile(git_head)[1]
        if branch_ref and branch_ref:match("ref: refs/heads/(.+)") then
          git_branch = "_" .. branch_ref:match("ref: refs/heads/(.+)")
        end
      end
      local path_hash = string.format("%x", vim.fn.hash(cwd)):sub(1, 8)
      return project_name .. git_branch .. "_" .. path_hash
    end,
    
    -- Directory handling
    suppressed_dirs = { 
      "~/", 
      "~/Projects", 
      "~/Downloads", 
      "/",
      vim.fn.expand("~/workspace/work/client-projects/tests/*")
    },
    cwd_change_handling = false,
    
    -- Git branch integration
    git_use_branch_name = false,
    git_auto_restore_on_branch_change = false,
    
    -- File type filtering - Updated for neo-tree
    bypass_save_filetypes = { 
      "alpha", 
      "dashboard", 
      "neo-tree",           
      "neo-tree-popup",
      "notify"
    },
    close_filetypes_on_save = { 
      "checkhealth",
      "neo-tree-popup"     
    },
    
    -- Session lens configuration
    session_lens = {
      picker = "telescope", 
      load_on_setup = true,
      mappings = {
        delete_session = { "i", "<C-d>" },
        alternate_session = { "i", "<C-s>" },
        copy_session = { "i", "<C-y>" },
      },
      picker_opts = {
        layout_config = {
          width = 0.8,
          height = 0.5,
        },
      },
    },
    
    -- FIXED: Enhanced hooks to handle window layout properly
    pre_save_cmds = {
      function()
        -- Store current window layout info before closing neo-tree
        vim.g.neotree_was_open = true
        vim.g.neotree_position = "left"
        vim.g.neotree_width = 30
        
        -- Check if neo-tree is currently open and store its state
        local manager_avail, manager = pcall(require, "neo-tree.sources.manager")
        if manager_avail then
          for _, source in ipairs({ "filesystem", "buffers", "git_status" }) do
            local state = manager.get_state(source)
            if state.winid and vim.api.nvim_win_is_valid(state.winid) then
              vim.g.neotree_was_open = true
              -- Store window position and size
              local win_config = vim.api.nvim_win_get_config(state.winid)
              vim.g.neotree_width = vim.api.nvim_win_get_width(state.winid)
              vim.g.neotree_position = state.position or "left"
              -- Close the window
              vim.api.nvim_win_close(state.winid, false)
              break
            end
          end
        end
      end,
    },
    
    post_restore_cmds = {
      function()
        -- Refresh lualine after restore
        if package.loaded.lualine then
          require("lualine").refresh()
        end
        
        -- FIXED: Properly restore neo-tree with correct window layout
        vim.defer_fn(function()
          -- Ensure we have proper window splits before opening neo-tree
          local current_windows = vim.api.nvim_list_wins()
          
          -- If neo-tree was open before saving, restore it properly
          if vim.g.neotree_was_open then
            -- Make sure we have at least one regular buffer window
            local has_regular_buffer = false
            for _, winid in ipairs(current_windows) do
              local bufnr = vim.api.nvim_win_get_buf(winid)
              local buftype = vim.api.nvim_buf_get_option(bufnr, 'buftype')
              local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
              
              if buftype == '' and filetype ~= 'neo-tree' then
                has_regular_buffer = true
                break
              end
            end
            
            -- If no regular buffer, create one first
            if not has_regular_buffer then
              vim.cmd('enew')
            end
            
            -- Now open neo-tree with proper positioning
            local position = vim.g.neotree_position or "left"
            local width = vim.g.neotree_width or 30
            
            -- Open neo-tree with explicit position and size
            vim.cmd(string.format("Neotree show position=%s", position))
            
            -- Set the correct width after opening
            vim.defer_fn(function()
              local manager_avail, manager = pcall(require, "neo-tree.sources.manager")
              if manager_avail then
                local state = manager.get_state("filesystem")
                if state.winid and vim.api.nvim_win_is_valid(state.winid) then
                  vim.api.nvim_win_set_width(state.winid, width)
                end
              end
            end, 50)
          end
          
          -- Clean up global variables
          vim.g.neotree_was_open = nil
          vim.g.neotree_position = nil
          vim.g.neotree_width = nil
        end, 100)
      end,
    },
    
    -- Cleanup and optimization
    auto_delete_empty_sessions = true,
    close_unsupported_windows = true,
    purge_after_minutes = 14400,
    
    -- Logging
    log_level = "error",
    show_auto_restore_notif = false,
  },
}

