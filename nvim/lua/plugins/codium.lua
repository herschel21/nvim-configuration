-- return {
--     "Exafunction/codeium.nvim",
--     dependencies = {
--         "nvim-lua/plenary.nvim",
--         "hrsh7th/nvim-cmp" -- Optional, but recommended
--     },
--     config = function()
--         require("codeium").setup({
--             -- Enterprise mode (optional)
--             -- enterprise_mode = false,
--
--             -- Workspace root configuration
--             workspace_root = {
--                 use_lsp = true,
--                 paths = {
--                     ".git",
--                     "package.json",
--                     "pyproject.toml"
--                 }
--             },
--
--             -- Virtual text configuration
--             virtual_text = {
--                 enabled = true,
--                 manual = false,
--                 idle_delay = 75,
--                 filetypes = {
--                     python = true,
--                     javascript = true,
--                     typescript = true,
--                     lua = true
--                 },
--                 default_filetype_enabled = true,
--                 virtual_text_priority = 65535,
--                 
--                 -- Key bindings for virtual text mode
--                 key_bindings = {
--                     accept = "<Tab>",
--                     accept_word = false,
--                     accept_line = false,
--                     clear = false,
--                     next = "<M-]>",
--                     prev = "<M-["
--                 }
--             },
--
--             -- Additional optional configurations
--             enable_chat = true,
--             detect_proxy = true,
--             enable_cmp_source = true
--         })
--     end
-- }
return {
    "Exafunction/codeium.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-telescope/telescope.nvim",
        "hrsh7th/nvim-cmp"
    },
    config = function()
        -- Set custom highlights similar to ChatGPT
        vim.api.nvim_set_hl(0, 'CodeiumNormalFloat', { bg = 'NONE', fg = 'NONE' })
        vim.api.nvim_set_hl(0, 'CodeiumFloatBorder', { bg = 'NONE', fg = 'NONE' })

        require("codeium").setup({
            enable_chat = true,
            workspace_root = {
                use_lsp = true,
                paths = {
                    ".git",
                    "package.json"
                }
            },
            virtual_text = {
                enabled = true,
                idle_delay = 75
            },
            
            -- Customize chat window to match ChatGPT style
            chat = {
                popup_layout = {
                    default = 'center',
                    center = {
                        width = '60%',
                        height = '80%'
                    }
                },
                popup_window = {
                    border = {
                        style = 'rounded',
                        text = {
                            top = ' Codeium Chat '
                        }
                    },
                    win_options = {
                        wrap = true,
                        linebreak = true,
                        winhighlight = 'Normal:CodeiumNormalFloat,FloatBorder:CodeiumFloatBorder'
                    }
                }
            }
        })

        -- Optional: Create a custom command to open Codeium Chat with specific styling
        vim.api.nvim_create_user_command('CodeiumChatCustom', function()
            -- This will open Codeium Chat in a styled window
            vim.cmd('Codeium Chat')
        end, {})
    end
}
