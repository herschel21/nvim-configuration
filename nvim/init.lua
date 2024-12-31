require("core.options")
require("core.snippets")
require("core.keymaps")

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        error("Error cloning lazy.nvim:\n" .. out)
    end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
require("lazy").setup({
    require("plugins.neotree"),
    require("plugins.autopairs"),
    require("plugins.colortheme"),
    require("plugins.bufferline"),
    require("plugins.lsp"),
    require("plugins.lualine"),
    require("plugins.telescope"),
    require("plugins.autocompletion"),
    require("plugins.alpha"),
    require("plugins.indent-blankline"),
    require("plugins.comment"),
    require("plugins.lazy_dev"),
    require("plugins.aerial"),
    require("plugins.terminal"),
}, {
    ui = {
        -- If you have a Nerd Font, set icons to an empty table which will use the
        -- default lazy.nvim defined Nerd Font icons otherwise define a unicode icons table
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
})
-- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).

require("mason").setup()

-- Function to check if a file exists
local function file_exists(file)
    local f = io.open(file, "r")
    if f then
        f:close()
        return true
    else
        return false
    end
end

-- Path to the session file
local session_file = ".session.vim"

-- Check if the session file exists in the current directory
if file_exists(session_file) then
    -- Source the session file
    vim.cmd("source " .. session_file)
end
