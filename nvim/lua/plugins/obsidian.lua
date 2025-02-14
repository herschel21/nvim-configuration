return {
  {
    'ada0l/obsidian',
    lazy = 'VeryLazy',
    dependencies = { 'ibhagwan/fzf-lua' }, -- Added fzf-lua as a dependency
    keys = {
      { '<leader>ov', '<cmd>lua require("obsidian").vault_prompt()<cr>', desc = 'Vault prompt' },
      { '<leader>on', '<cmd>lua require("obsidian").new_note_prompt()<cr>', desc = 'New note' },
      { '<leader>ot', '<cmd>lua require("obsidian").open_today()<cr>', desc = 'Open today' },
      { '<leader>oT', '<cmd>lua require("obsidian").open_today_prompt()<cr>', desc = 'Open today (shift)' },
      { '<leader>of', '<cmd>lua require("obsidian").note_picker()<cr>', desc = 'Note picker' },
      {
        'gf',
        function()
          if require('obsidian').found_wikilink_under_cursor() ~= nil then
            return '<cmd>lua require("obsidian").go_to()<CR>'
          else
            return 'gf'
          end
        end,
        noremap = false,
        expr = true,
      },
    },
    ---@type ObsidianOptions
    opts = {
      extra_fd_opts = '--exclude assets --exclude journals --exclude _debug_remotely_save',
      vaults = {
        {
          dir = '~/workspace/work/vayavya/meeting_notes/',
          daily = {
            dir = 'journals',
            format = '%d-%m-%Y',
          },
          note = {
            dir = '.',
            transformator = function(filename)
              if filename ~= nil and filename ~= '' then
                return filename
              end
              return string.format('%d', os.time())
            end,
          },
          templates = {
            dir = 'templates',
            date = '%d-%m-%Y',
            time = '%d-%m-%Y',
          },
        },
      },
    },
  },
  {
    'ibhagwan/fzf-lua', -- Added fzf-lua as a separate lazy.nvim plugin
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
}

