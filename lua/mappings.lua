-- ~/.config/nvim/lua/mappings.lua
require "nvchad.mappings"

local map = vim.keymap.set

-- Leader key
vim.g.mapleader = " "

-- Original mappings you had before
-- map("n", "<Leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Toggle Trouble" })
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- File operations (VS Code-like)
map("n", "<C-s>", ":w<CR>", { noremap = true, silent = true }) -- Save with Ctrl+S
map("i", "<C-s>", "<Esc>:w<CR>a", { noremap = true, silent = true }) -- Save in insert mode

-- Window navigation
map("n", "<C-h>", "<C-w>h", { noremap = true, silent = true }) -- Left window
map("n", "<C-j>", "<C-w>j", { noremap = true, silent = true }) -- Down window
map("n", "<C-k>", "<C-w>k", { noremap = true, silent = true }) -- Up window
map("n", "<C-l>", "<C-w>l", { noremap = true, silent = true }) -- Right window

-- Split windows (VS Code-like)
map("n", "<leader>\\", ":vsplit<CR>", { noremap = true, silent = true }) -- Vertical split
map("n", "<leader>-", ":split<CR>", { noremap = true, silent = true }) -- Horizontal split

-- Close buffer without closing window (VS Code-like)
map("n", "<leader>x", ":bd<CR>", { noremap = true, silent = true }) -- Close current buffer

-- Show file explorer
map("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true }) -- Toggle file explorer with Ctrl+n

-- IMPORTANT: NvChad specific mappings
-- Theme switcher (restore original NvChad behavior
map("n", "<leader>th", "<cmd> Telescope themes <CR>", { desc = "Select theme" })

-- Cheatsheet (restore original NvChad behavior)
map("n", "<leader>ch", "<cmd> NvCheatsheet <CR>", { desc = "Mapping cheatsheet" })

-- Toggle Terminal (different than original mapping)
map("n", "<A-t>", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })

-- Code navigation
map("n", "gd", ":lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true }) -- Go to definition
map("n", "gI", ":lua vim.lsp.buf.implementation()<CR>", { noremap = true, silent = true }) -- Go to implementation
map("n", "gR", ":lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true }) -- Find references
map("n", "K", ":lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true }) -- Show documentation
map("n", "<leader>r", ":lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true }) -- Rename symbol

-- Telescope with leader mappings (if Ctrl keys interfere with terminal)
map("n", "<leader>ff", "<cmd> Telescope find_files <CR>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd> Telescope live_grep <CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd> Telescope buffers <CR>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd> Telescope help_tags <CR>", { desc = "Help page" })
map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>", { desc = "Find oldfiles" })
map("n", "<leader>fw", "<cmd> Telescope current_buffer_fuzzy_find <CR>", { desc = "Find in current buffer" })

-- LSP mappings (preserve NvChad behavior)
map("n", "<leader>lf", "<cmd> lua vim.lsp.buf.format() <CR>", { desc = "Format code" })
map("n", "<leader>ls", "<cmd> Telescope lsp_document_symbols <CR>", { desc = "Document symbols" })

-- Other common NvChad mappings
map("n", "<leader>n", "<cmd> enew <CR>", { desc = "New buffer" })
map("n", "<leader>cm", "<cmd> Telescope git_commits <CR>", { desc = "Git commits" })

-- Use Tab and Shift-Tab to navigate completion suggestions
-- map("i", "<Tab>", "v:lua.tab_complete()", { expr = true, silent = true })
-- map("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true, silent = true })
