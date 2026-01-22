return {
    "Exafunction/codeium.nvim",
    event = "InsertEnter",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp" -- Optional, but recommended
    },
    config = function()
        require("codeium").setup({
            -- Enterprise mode (optional)
            -- enterprise_mode = false,

            -- Workspace root configuration
            workspace_root = {
                use_lsp = true,
                paths = {
                    ".git",
                    "package.json",
                    "pyproject.toml"
                }
            },

            -- Virtual text configuration
            virtual_text = {
                enabled = true,
                manual = false,
                idle_delay = 75,
                filetypes = {
                    python = true,
                    javascript = true,
                    typescript = true,
                    lua = true
                },
                default_filetype_enabled = true,
                virtual_text_priority = 65535,
                
                -- Key bindings for virtual text mode
                key_bindings = {
                    accept = "<leader><Tab>",
                    accept_word = false,
                    accept_line = false,
                    clear = false,
                    next = "<M-]>",
                    prev = "<M-["
                }
            },

            -- Additional optional configurations
            enable_chat = true,
            detect_proxy = true,
            enable_cmp_source = true
        })
    end
}
