-- Search
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.inccommand = "split"
vim.o.ignorecase = true
vim.o.smartcase = true

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 4

-- Indentation
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.breakindent = true

-- UI
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.showmode = false
vim.o.showtabline = 2
vim.o.pumheight = 10
vim.o.cmdheight = 1
vim.o.conceallevel = 0
vim.opt.termguicolors = true

-- Splits
vim.o.splitbelow = true
vim.o.splitright = true

-- Scroll
vim.o.scrolloff = 4
vim.o.sidescrolloff = 8

-- Wrapping
vim.o.wrap = false
vim.o.linebreak = true
vim.o.whichwrap = "bs<>[]hl"

-- Files
vim.o.undofile = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.fileencoding = "utf-8"

-- Behaviour
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = "menuone,noselect"
vim.o.backspace = "indent,eol,start"
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Append options
vim.opt.shortmess:append("c")
vim.opt.iskeyword:append("-")
vim.opt.formatoptions:remove({ "c", "r", "o" })
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")
