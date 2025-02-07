require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- Map key to toggle the Trouble window
map("n", "<Leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Toggle Trouble" })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
