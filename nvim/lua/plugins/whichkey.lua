return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
    config = function()
        local wk = require("which-key")
        
        wk.setup({
            preset = "modern",
            delay = 300,
            filter = function(mapping)
                -- Hide some mappings
                return mapping.desc and mapping.desc ~= ""
            end,
            spec = {},
            notify = true,
            triggers = {
                { "<auto>", mode = "nxsot" },
            },
            defer = function(ctx)
                if vim.list_contains({ "d", "y", "c" }, ctx.operator) then
                    return true
                end
                return vim.list_contains({ "<C-V>", "V" }, ctx.mode)
            end,
            plugins = {
                marks = true,
                registers = true,
                spelling = {
                    enabled = true,
                    suggestions = 20,
                },
                presets = {
                    operators = true,
                    motions = true,
                    text_objects = true,
                    windows = true,
                    nav = true,
                    z = true,
                    g = true,
                },
            },
            win = {
                border = "rounded",
                padding = { 1, 2 },
                wo = {
                    winblend = 0,
                },
            },
            layout = {
                width = { min = 20 },
                spacing = 3,
            },
            keys = {
                scroll_down = "<c-d>",
                scroll_up = "<c-u>",
            },
        })

        -- Add all keymaps using the new v3 spec
        wk.add({
            -- Basic navigation and editing
            { "<C-s>", ":noautocmd w<CR>", desc = "Save file" },
            { "<Esc>", ":noh<CR>", desc = "Clear highlights" },
            { "<S-h>", ":bprevious<CR>", desc = "Previous buffer" },
            { "<S-l>", ":bnext<CR>", desc = "Next buffer" },
            { "<C-h>", ":wincmd h<CR>", desc = "Go to left window" },
            { "<C-j>", ":wincmd j<CR>", desc = "Go to down window" },
            { "<C-k>", ":wincmd k<CR>", desc = "Go to up window" },
            { "<C-l>", ":wincmd l<CR>", desc = "Go to right window" },
            { "<C-d>", "<C-d>zz", desc = "Scroll down and center" },
            { "<C-u>", "<C-u>zz", desc = "Scroll up and center" },
            
            -- Neo-tree
            { "<leader>e", ":Neotree toggle position=left<CR>", desc = "Toggle file explorer" },
            { "\\", ":Neotree reveal<CR>", desc = "Reveal current file in explorer" },
            
            -- Aerial
            { "<leader>o", ":AerialToggle!<CR>", desc = "Toggle code outline" },
            { "<leader>on", ":AerialNavToggle<CR>", desc = "Toggle aerial navigation" },
            
            -- Telescope
            { "<C-p>", ":Telescope find_files<CR>", desc = "Find files" },
            { "<leader>?", ":Telescope oldfiles<CR>", desc = "Recently opened files" },
            { "<leader>/", function()
                require("telescope.builtin").current_buffer_fuzzy_find(
                    require("telescope.themes").get_dropdown({
                        winblend = 10,
                        previewer = false,
                    })
                )
            end, desc = "Fuzzy search in current buffer" },

            -- Leader key groups
            { "<leader>", group = "Leader" },
            { "<leader>q", ":q<CR>", desc = "Quit" },
            { "<leader>b", ":enew<CR>", desc = "New buffer" },
            { "<leader>x", ":Bdelete!<CR>", desc = "Close buffer" },
            { "<leader>y", '"+y', desc = "Yank to system clipboard", mode = { "n", "v" } },
            { "<leader>Y", '"+Y', desc = "Yank line to system clipboard" },
            { "<leader>+", "<C-a>", desc = "Increment number" },
            { "<leader>-", "<C-x>", desc = "Decrement number" },
            { "<leader>j", "*``cgn", desc = "Replace word under cursor" },

            -- Split/Search group
            { "<leader>s", group = "Split/Search" },
            { "<leader>sv", "<C-w>v", desc = "Split vertically" },
            { "<leader>sh", "<C-w>s", desc = "Split horizontally" },
            { "<leader>se", "<C-w>=", desc = "Equal window size" },
            { "<leader>sz", ":close<CR>", desc = "Close window" },
            { "<leader>sf", ":Telescope find_files<CR>", desc = "Find files" },
            { "<leader>sg", ":Telescope live_grep<CR>", desc = "Live grep" },
            { "<leader>sb", ":Telescope buffers<CR>", desc = "Find buffers" },
            { "<leader>sw", ":Telescope grep_string<CR>", desc = "Search word under cursor" },
            { "<leader>sd", ":Telescope diagnostics<CR>", desc = "Diagnostics" },
            { "<leader>sr", ":Telescope resume<CR>", desc = "Resume last search" },
            { "<leader>sm", ":Telescope marks<CR>", desc = "Marks" },
            { "<leader>s.", ":Telescope oldfiles<CR>", desc = "Recent files" },
            { "<leader>s/", function()
                require("telescope.builtin").live_grep({
                    grep_open_files = true,
                    prompt_title = "Live Grep in Open Files",
                })
            end, desc = "Search in open files" },

            -- Git group
            { "<leader>g", group = "Git" },
            { "<leader>gs", ":Git<CR>", desc = "Git status" },
            { "<leader>ga", ":Git add .<CR>", desc = "Git add all" },
            { "<leader>gc", ":Git commit<CR>", desc = "Git commit" },
            { "<leader>gca", ":Git commit --amend<CR>", desc = "Git commit amend" },
            { "<leader>gp", ":Git push<CR>", desc = "Git push" },
            { "<leader>gpf", ":Git push --force-with-lease<CR>", desc = "Git push force" },
            { "<leader>gl", ":Git pull<CR>", desc = "Git pull" },
            { "<leader>gd", ":Gdiffsplit<CR>", desc = "Git diff" },
            { "<leader>gb", ":Git blame<CR>", desc = "Git blame" },
            { "<leader>glg", ":Git log --oneline<CR>", desc = "Git log" },
            { "<leader>gll", ":Git log<CR>", desc = "Git log detailed" },

            -- Tabs group
            { "<leader>t", group = "Tabs" },
            { "<leader>to", ":tabnew<CR>", desc = "New tab" },
            { "<leader>tx", ":tabclose<CR>", desc = "Close tab" },
            { "<leader>tn", ":tabn<CR>", desc = "Next tab" },
            { "<leader>tp", ":tabp<CR>", desc = "Previous tab" },

            -- Line operations
            { "<leader>l", group = "Line" },
            { "<leader>lw", ":set wrap!<CR>", desc = "Toggle line wrap" },

            -- Diagnostics
            { "<leader>d", group = "Diagnostics" },
            { "<leader>do", function()
                local diagnostics_active = not vim.diagnostic.is_disabled()
                if diagnostics_active then
                    vim.diagnostic.disable(0)
                else
                    vim.diagnostic.enable(0)
                end
            end, desc = "Toggle diagnostics" },

            -- Session management
            { "<leader>ss", ":mksession! .session.vim<CR>", desc = "Save session" },
            { "<leader>sl", ":source .session.vim<CR>", desc = "Load session" },

            -- Buffer number navigation
            { "<leader>1", function() require('bufferline').go_to_buffer(1, true) end, desc = "Go to buffer 1" },
            { "<leader>2", function() require('bufferline').go_to_buffer(2, true) end, desc = "Go to buffer 2" },
            { "<leader>3", function() require('bufferline').go_to_buffer(3, true) end, desc = "Go to buffer 3" },
            { "<leader>4", function() require('bufferline').go_to_buffer(4, true) end, desc = "Go to buffer 4" },
            { "<leader>5", function() require('bufferline').go_to_buffer(5, true) end, desc = "Go to buffer 5" },
            { "<leader>6", function() require('bufferline').go_to_buffer(6, true) end, desc = "Go to buffer 6" },
            { "<leader>7", function() require('bufferline').go_to_buffer(7, true) end, desc = "Go to buffer 7" },
            { "<leader>8", function() require('bufferline').go_to_buffer(8, true) end, desc = "Go to buffer 8" },
            { "<leader>9", function() require('bufferline').go_to_buffer(9, true) end, desc = "Go to buffer 9" },

            -- Visual mode mappings
            { "<", "<gv", desc = "Indent left and reselect", mode = "v" },
            { ">", ">gv", desc = "Indent right and reselect", mode = "v" },
            { "<A-j>", ":m .+1<CR>==", desc = "Move line down", mode = "v" },
            { "<A-k>", ":m .-2<CR>==", desc = "Move line up", mode = "v" },
            { "p", '"_dP', desc = "Paste without yanking", mode = "v" },

            -- Insert mode mappings
            { "jk", "<Esc>", desc = "Exit insert mode", mode = "i" },
            { "kj", "<Esc>", desc = "Exit insert mode", mode = "i" },

            -- LSP mappings (these will be available when LSP is active)
            { "g", group = "Go to" },
            { "gd", function() require('telescope.builtin').lsp_definitions() end, desc = "Go to definition" },
            { "gr", function() require('telescope.builtin').lsp_references() end, desc = "Go to references" },
            { "gI", function() require('telescope.builtin').lsp_implementations() end, desc = "Go to implementation" },
            { "gD", vim.lsp.buf.declaration, desc = "Go to declaration" },
            { "D", function() require('telescope.builtin').lsp_type_definitions() end, desc = "Type definition" },
            { "ds", function() require('telescope.builtin').lsp_document_symbols() end, desc = "Document symbols" },
            { "ws", function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end, desc = "Workspace symbols" },

            -- Code operations
            { "<leader>c", group = "Code" },
            { "<leader>ca", vim.lsp.buf.code_action, desc = "Code action", mode = { "n", "v" } },
            
            -- Rename operations
            { "<leader>r", group = "Rename/Replace" },
            { "<leader>rn", vim.lsp.buf.rename, desc = "Rename symbol" },
        })
    end,
}

