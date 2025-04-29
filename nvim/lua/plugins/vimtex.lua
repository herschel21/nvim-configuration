return {
    'lervag/vimtex',  -- vimtex plugin for LaTeX editing
    ft = 'tex',       -- Only load vimtex when editing tex files
    config = function()
      -- Set up vimtex-specific settings here
      vim.g.vimtex_view_method = 'zathura'  -- Example: Use Zathura for PDF viewing
      vim.g.vimtex_quickfix_mode = 0        -- Example: Disable quickfix mode
      vim.g.vimtex_fold_enabled = 1         -- Enable folding for vimtex
    end
  }
