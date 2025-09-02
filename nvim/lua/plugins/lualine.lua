return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'moll/vim-bbye', -- For buffer deletion
    },
    config = function()
        -- Catppuccin mocha colors
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
            fmt = function(str)
                return '  ' .. str
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

        -- Buffer tabs configuration
        local buffers = {
            'buffers',
            show_filename_only = true,
            hide_filename_extension = false,
            show_modified_status = true,
            mode = 0, -- 0: shows buffer name, 1: shows buffer index, 2: shows buffer name + buffer index, 3: shows buffer number, 4: shows buffer name + buffer number
            max_length = vim.o.columns * 2 / 3,
            filetype_names = {
                TelescopePrompt = 'Telescope',
                dashboard = 'Dashboard',
                packer = 'Packer',
                fzf = 'FZF',
                alpha = 'Alpha'
            },
            buffers_color = {
                active = { fg = colors.text, bg = colors.accent, gui = 'bold' },
                inactive = { fg = colors.muted, bg = colors.bg },
            },
            symbols = {
                modified = ' ●',
                alternate_file = '#',
                directory = '',
            },
        }

        require('lualine').setup({
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
                lualine_b = { 'branch', diff },
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
            -- Use tabline for buffer tabs
            tabline = {
                lualine_a = { buffers },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { 'tabs' }
            },
            extensions = { 'fugitive', 'neo-tree' },
        })

        -- Buffer navigation keymaps (same as your bufferline)
        local opts = { noremap = true, silent = true }
        vim.keymap.set("n", "<S-l>", ":bnext<CR>", opts)
        vim.keymap.set("n", "<S-h>", ":bprevious<CR>", opts)
        
        -- Go to specific buffer by number
        for i = 1, 9 do
            vim.keymap.set('n', '<leader>' .. i, function()
                local buffers = vim.fn.getbufinfo({buflisted = 1})
                if buffers[i] then
                    vim.api.nvim_set_current_buf(buffers[i].bufnr)
                end
            end, { desc = 'Go to Buffer ' .. i })
        end
        
        -- Close buffer
        vim.keymap.set("n", "<leader>x", ":Bdelete!<CR>", opts)
    end,
}

