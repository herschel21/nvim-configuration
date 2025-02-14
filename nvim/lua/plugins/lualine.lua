return {
  'nvim-lualine/lualine.nvim',
  config = function()
    -- Catppuccin mocha colors
    local colors = {
      bg = '#11121d',       -- Base
      fg = '#cdd6f4',       -- Text
      accent = '#7aa2f7',   -- Red
      highlight = '#9ece6a', -- Green
      muted = '#45475a',    -- Surface1
      subtle = '#f9e2af',   -- Yellow
      text = '#cdd6f4',     -- Text
    }

    -- Keep original theme structure with Catppuccin colors
    local catppuccin_theme = {
      normal = {
        a = { fg = colors.bg, bg = colors.accent, gui = 'bold' },
        b = { fg = colors.text, bg = colors.muted },
        c = { fg = colors.fg, bg = colors.bg },
      },
      insert = { a = { fg = colors.bg, bg = colors.highlight, gui = 'bold' } },
      visual = { a = { fg = colors.bg, bg = colors.subtle, gui = 'bold' } },
      replace = { a = { fg = colors.bg, bg = colors.accent, gui = 'bold' } },
      command = { a = { fg = colors.bg, bg = colors.muted, gui = 'bold' } },
      inactive = {
        a = { fg = colors.muted, bg = colors.bg, gui = 'bold' },
        b = { fg = colors.muted, bg = colors.bg },
        c = { fg = colors.muted, bg = colors.bg },
      },
    }

    -- Keep all original component configurations
    local mode = {
      'mode',
      fmt = function(str)
        return ' ' .. str
      end,
    }

    local filename = {
      'filename',
      file_status = true,
      path = 0,
    }

    local diagnostics = {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      sections = { 'error', 'warn', 'info', 'hint' },
      symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
      colored = true,
    }

    local diff = {
      'diff',
      colored = true,
      symbols = { added = ' ', modified = '柳', removed = ' ' },
    }

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = catppuccin_theme,
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = { 'alpha', 'neo-tree' },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { 'branch', 'diff' },
        lualine_c = { filename },
        lualine_x = { diagnostics, 'encoding', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { { 'location', padding = 0 } },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { 'fugitive' },
    }
  end,
}
