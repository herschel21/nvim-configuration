return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        -- Embedded systems ASCII art
			dashboard.section.header.val = {
			[[⠈⠙⠲⢶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣿⡀⠀⠀⠀⠀⠀⠀⠀⡄⠀⠀⡄⠀⠀⠀⠀⠀⠀⠀⣼⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣿⠟⠓⠉]],
			[[⠀⠀⠀⠀⠈⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⢀⣧⣶⣦⣇⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠉⠀⠀⠀⠀]],
			[[⠀⠀⠀⠀⠀⠀⠀⠙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶⣶⣶⣾⣿⣿⣿⣿⣶⣶⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀]],
			[[⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⠛⠛⠛⠛⠛⠛⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠿⠟⠛⠛⠛⠛⠛⠛⠃⠀⠀⠀⠀⠀⠀⠀ ]],
			[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			}
        -- Buttons with embedded development focus
        dashboard.section.buttons.val = {
            dashboard.button("p", "  Project Files", ":Telescope git_files <CR>"),
            dashboard.button("f", "  Find Files", ":Telescope find_files <CR>"),
            dashboard.button("c", "  Edit Config", ":e ~/.config/nvim/init.lua <CR>"),
            dashboard.button("r", "  Recent Files", ":Telescope oldfiles <CR>"),
            dashboard.button("g", "  Git Status", ":Neogit <CR>"),
            dashboard.button("t", "  Find Text", ":Telescope live_grep <CR>"),
            dashboard.button("m", "  Mason (LSP)", ":Mason <CR>"),
            dashboard.button("l", "󰒲  Lazy (Plugins)", ":Lazy <CR>"),
            dashboard.button("q", "  Quit", ":qa <CR>"),
        }

        -- System information footer
        local function get_system_info()
            local lazy_stats = require("lazy").stats()
            local plugins_count = lazy_stats.loaded .. "/" .. lazy_stats.count
            local datetime = os.date("%Y-%m-%d %H:%M:%S")
            local nvim_version = "NVIM v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch

            return {
                "",
                "󰒲 " .. plugins_count .. " plugins loaded",
                " " .. datetime,
                " " .. nvim_version,
                "",
                ""
            }
        end

        dashboard.section.footer.val = get_system_info()

        -- Custom highlighting
        dashboard.section.header.opts.hl = "String"
        dashboard.section.buttons.opts.hl = "Function"
        dashboard.section.footer.opts.hl = "Comment"

        -- Setup
        alpha.setup(dashboard.opts)

        -- Hide statusline in alpha
        vim.api.nvim_create_autocmd("User", {
            pattern = "AlphaReady",
            callback = function()
                local old_laststatus = vim.o.laststatus
                vim.api.nvim_create_autocmd("BufUnload", {
                    buffer = 0,
                    callback = function()
                        vim.o.laststatus = old_laststatus
                    end,
                })
                vim.opt.laststatus = 0
            end,
        })
    end,
}

