return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- Using the "classic" preset by default
    preset = "classic",
    
    -- Customizing the delay based on context
    delay = function(ctx)
      return ctx.plugin and 0 or 200
    end,
    
    plugins = {
      marks = true,         -- Show marks when pressing ' and `
      registers = true,     -- Show registers on " in NORMAL or <C-r> in INSERT mode
      spelling = {
        enabled = true,     -- Show WhichKey when pressing z= for spelling suggestions
        suggestions = 20,   -- Number of suggestions to show
      },
      -- Enable helpful presets
      presets = {
        operators = true,    -- Help for operators like d, y, etc.
        motions = true,      -- Help for motions
        text_objects = true, -- Help for text objects triggered after operators
        windows = true,      -- Default bindings on <c-w>
        nav = true,          -- Misc bindings to work with windows
        z = true,            -- Bindings for folds, spelling and others prefixed with z
        g = true,            -- Bindings prefixed with g
      },
    },
    
    -- Window appearance configuration
    win = {
      no_overlap = true,     -- Don't allow popup to overlap with cursor
      padding = { 1, 2 },    -- Extra window padding [top/bottom, right/left]
      title = true,
      title_pos = "center",
      zindex = 1000,
      wo = {
        winblend = 10,       -- Slight transparency for the popup
      },
    },
    
    -- Layout configuration
    layout = {
      width = { min = 20 },  -- Min width of columns
      spacing = 3,           -- Spacing between columns
    },
    
    -- Keys for navigating the popup
    keys = {
      scroll_down = "<c-d>",
      scroll_up = "<c-u>",
    },
    
    -- Sorting order of mappings
    sort = { "local", "order", "group", "alphanum", "mod" },
    
    -- Automatically expand groups with few mappings
    expand = 3,
    
    -- Icon configuration (requires Nerd Font)
    icons = {
      breadcrumb = "»",    -- Symbol in command line showing key combo
      separator = "➜",     -- Symbol between key and label
      group = "+",         -- Symbol for groups
      mappings = true,     -- Enable icons for mappings
      colors = true,       -- Use mini.icons highlights when available
    },
    
    -- Show help message and currently pressed keys
    show_help = true,
    show_keys = true,
    
    -- Add custom triggers
    triggers = {
      { "<auto>", mode = "nxsotc" },  -- Auto-setup triggers for all modes
      { "<leader>", mode = { "n", "v" } }, -- Explicitly trigger on <leader>
    },
  },
  
  -- Add some useful keymaps for Which-Key itself
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
    {
      "<leader>wk",
      function()
        require("which-key").show()
      end,
      desc = "Show All Keymaps (which-key)",
    },
  },
  
  -- Add some custom mappings and groups
  config = function(_, opts)
    local wk = require("which-key")
    -- Initialize with options
    wk.setup(opts)
    
    -- Add common keymap groups for organization
    wk.add({
      { "<leader>f", group = "Find/File" },
      { "<leader>b", group = "Buffer" },
      { "<leader>g", group = "Git" },
      { "<leader>l", group = "LSP" },
      { "<leader>t", group = "Toggle" },
      { "<leader>w", group = "Window" },
      
      -- Window management proxy (makes <leader>w act like <C-w>)
      { "<leader>w", proxy = "<c-w>", desc = "Window Commands" },
      
      -- Example of dynamic buffer list
      { "<leader>b", group = "Buffer", expand = function()
          return require("which-key.extras").expand.buf()
        end
      },
    })
  end,
}
