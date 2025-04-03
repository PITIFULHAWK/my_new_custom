-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "dark_horizon",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}
M.plugins = "plugins"

-- React Native specific keybindings
M.setup = function()
  -- Setup React Native specific LSP settings
  vim.g.react_native_typescript = true
  vim.g.react_native_hot_reload = true
end

return M
