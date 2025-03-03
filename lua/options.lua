-- ~/.config/nvim/lua/options.lua

require "nvchad.options"

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = false -- VS Code doesn't use relative line numbers

-- Tabs & Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Line wrapping
opt.wrap = true -- VS Code doesn't wrap by default

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.background = "dark" -- or "light" depending on your preference
opt.signcolumn = "yes" -- Always show sign column (for git signs, errors)
opt.cursorline = true -- Highlight current line
opt.cursorlineopt = "both"
opt.scrolloff = 8 -- Minimum lines to keep above/below cursor

-- Behavior
opt.hidden = true -- Allow switching buffers without saving
opt.updatetime = 300 -- Faster completion
opt.timeoutlen = 500 -- By default timeoutlen is 1000 ms
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.mouse = "a" -- Enable mouse support (like VS Code)
opt.splitright = true -- Split windows to the right
opt.splitbelow = true -- Split windows below

-- Decrease redraw time
opt.lazyredraw = true

-- Set completeopt to have a better completion experience (like VS Code)
opt.completeopt = "menuone,noinsert,noselect"
