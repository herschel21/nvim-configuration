return {
  -- Bufferline configuration
  {
    'akinsho/bufferline.nvim',
    dependencies = {
      'moll/vim-bbye',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local status, bufferline = pcall(require, 'bufferline')
      if not status then
        print('Error: Failed to load bufferline.nvim')
        return
      end

      bufferline.setup {
        options = {
          mode = 'buffers', -- Show buffers, not tabs
          themable = true,
          numbers = 'none', -- No buffer numbers
          close_command = 'Bdelete! %d', -- Use Bdelete to close buffers
          right_mouse_command = 'Bdelete! %d',
          left_mouse_command = 'buffer %d',
          middle_mouse_command = nil,
          buffer_close_icon = '󰅖',
          close_icon = '',
          modified_icon = '●',
          left_trunc_marker = '',
          right_trunc_marker = '',
          max_name_length = 30,
          tab_size = 21,
          diagnostics = false, -- Disable diagnostics to simplify
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          separator_style = { '│', '│' },
          always_show_bufferline = true, -- Always show buffer bar
          indicator = { style = 'none' },
          icon_pinned = '󰐃',
          minimum_padding = 1,
          maximum_padding = 5,
          sort_by = 'insert_at_end',
        },
        highlights = {
          separator = { fg = '#434C5E' },
          buffer_selected = { bold = true, italic = false },
        },
      }

      -- Bufferline Keymaps
      local opts = { noremap = true, silent = true, desc = 'Go to Buffer' }
      local function set_keymap(key, cmd)
        local success, _ = pcall(vim.keymap.set, 'n', key, cmd, opts)
        if not success then
          print('Error: Failed to set keymap ' .. key)
        end
      end
      set_keymap('<Tab>', '<Cmd>BufferLineCycleNext<CR>')
      set_keymap('<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>')
      for i = 1, 9 do
        set_keymap('<leader>' .. i, "<cmd>lua require('bufferline').go_to_buffer(" .. i .. ")<CR>")
      end
    end,
  },

  -- Lualine configuration
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local status, lualine = pcall(require, 'lualine')
      if not status then
        print('Error: Failed to load lualine.nvim')
        return
      end

      local colors = {
        bg = '#11121d',
        fg = '#cdd6f4',
        accent = '#7aa2f7',
        highlight = '#9ece6a',
        muted = '#45475a',
        subtle = '#f9e2af',
        text = '#cdd6f4',
      }

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

      local mode = {
        'mode',
        fmt = function(str) return ' ' .. str end,
      }

      local filename = {
        'filename',
        file_status = true,
        path = 1,
        symbols = { modified = '●', readonly = '🔒' },
      }

      lualine.setup {
        options = {
          icons_enabled = true,
          theme = catppuccin_theme,
          section_separators = { left = '', right = '' },
          component_separators = { left = '│', right = '│' },
          disabled_filetypes = { 'alpha', 'neo-tree' },
          always_divide_middle = true,
        },
        sections = {
          lualine_a = { mode },
          lualine_b = { 'branch' },
          lualine_c = { filename },
          lualine_x = { 'encoding', 'filetype' },
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
        tabline = {}, -- Disable tabline to avoid interference
        extensions = { 'fugitive' },
      }
    end,
  },
}
