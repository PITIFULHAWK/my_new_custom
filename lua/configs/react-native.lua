-- ./lua/configs/react-native.lua
local M = {}

M.setup = function()
  -- React Native specific keybindings
  local opts = { noremap = true, silent = true }

  -- Run commands
  vim.keymap.set("n", "<leader>rna", ":term bun run android<CR>", opts)
  vim.keymap.set("n", "<leader>rni", ":term bun run ios<CR>", opts)
  vim.keymap.set("n", "<leader>rns", ":term bun start<CR>", opts)

  -- Development tools
  vim.keymap.set("n", "<leader>rnl", ":term bun run log-android<CR>", opts)
  vim.keymap.set("n", "<leader>rnr", ":term bun run reload<CR>", opts)

  -- Setup React Native specific LSP settings
  vim.g.react_native_typescript = true
  vim.g.react_native_hot_reload = true
end

return M
