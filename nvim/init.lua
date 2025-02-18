-- [[ Core Configuration ]]
require("core.options")
require("core.snippets")
require("core.keymaps")

-- [[ Bootstrap lazy.nvim ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- [[ Plugin Groups ]]
local plugins = {
    -- UI and Theming
    { import = "plugins.catpuccin" },    -- Theme
    { import = "plugins.bufferline" },   -- Buffer management
    { import = "plugins.lualine" },      -- Status line
    { import = "plugins.alpha" },        -- Dashboard
    { import = "plugins.indent-blankline" },
    { import = "plugins.autosession" },
    
    -- Editor Features
    { import = "plugins.neotree" },      -- File explorer
    { import = "plugins.telescope" },     -- Fuzzy finder
    { import = "plugins.aerial" },       -- Code outline
    { import = "plugins.autopairs" },    -- Auto brackets
    { import = "plugins.comment" },      -- Comments
    
    -- Development Tools
    { import = "plugins.lsp" },          -- Language Server Protocol
    { import = "plugins.autocompletion" },
    { import = "plugins.codium" },       -- AI completion
    { import = "plugins.cody" },         -- Sourcegraph
    { import = "plugins.neogit" },       -- Git interface
    
    -- Language Specific
    { import = "plugins.markdown" },
    { import = "plugins.vimtex" },
    
    -- Utilities
    { import = "plugins.terminal" },
    { import = "plugins.url-open" },
    { import = "plugins.obsidian" },
    { import = "plugins.lazy_dev" },
}

-- [[ Lazy.nvim Configuration ]]
require("lazy").setup(plugins, {
    install = {
        colorscheme = { "catppuccin" },
    },
    ui = {
        icons = vim.g.have_nerd_font and {} or {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            require = "🌙",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
    },
    change_detection = {
        enabled = true,
        notify = false,  -- Disable notifications on config change
    },
    performance = {
        cache = {
            enabled = true,
        },
        reset_packpath = true,
        rtp = {
            reset = true,
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})

-- [[ Mason Setup ]]
require("mason").setup({
    ui = {
        border = "rounded",
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- [[ Session Management ]]
local function load_session()
    local session_file = vim.fn.getcwd() .. "/.session.vim"
    if vim.fn.filereadable(session_file) == 1 then
        vim.cmd("source " .. session_file)
    end
end

-- Auto-save session on exit
vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        local session_file = vim.fn.getcwd() .. "/.session.vim"
        vim.cmd("mksession! " .. session_file)
    end,
})

-- Load session on startup if it exists
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        -- Only load session if nvim was started without arguments
        if vim.fn.argc() == 0 then
            load_session()
        end
    end,
})
