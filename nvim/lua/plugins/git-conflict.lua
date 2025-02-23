return {
  "akinsho/git-conflict.nvim",
  version = "*",
  config = function()
    require("git-conflict").setup({
      default_mappings = true,    -- use default mappings
      default_commands = true,    -- use default commands
      disable_diagnostics = false, -- don't disable diagnostics during conflict
      list_opener = 'copen',      -- command to open the quickfix list
      highlights = {              -- highlight groups for conflicts
        incoming = 'DiffAdd',
        current = 'DiffText',
      },
      -- Custom mappings if you prefer different keys
      default_mappings = {
        ours = 'o',      -- choose ours
        theirs = 't',    -- choose theirs
        none = '0',      -- choose none
        both = 'b',      -- choose both
        next = 'n',      -- next conflict
        prev = 'p',      -- previous conflict
      },
    })

    -- Optional: Add custom autocommands for conflict detection
    vim.api.nvim_create_autocmd('User', {
      pattern = 'GitConflictDetected',
      callback = function()
        vim.notify('Conflict detected in ' .. vim.fn.expand('<afile>'), vim.log.levels.WARN)
      end
    })

    -- Optional: Add autocommand for conflict resolution
    vim.api.nvim_create_autocmd('User', {
      pattern = 'GitConflictResolved',
      callback = function()
        vim.notify('Conflict resolved!', vim.log.levels.INFO)
      end
    })
  end
}
