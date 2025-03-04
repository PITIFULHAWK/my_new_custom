-- Load defaults (i.e., lua_lsp)
-- ./lua/configs/lspconfigs.lua

require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local servers = {
  "html",
  "cssls",
  "ts_ls",
  "tailwindcss",
  "eslint",
  "pyright",
  "jdtls",
  "clangd",
  "bashls",
  "yamlls",
  "dockerls",
  "terraformls",
  "jsonls",
  "prismals",
  "lua_ls", -- Added Lua LSP
  "rust_analyzer", -- Added Rust LSP
}

local nvlsp = require "nvchad.configs.lspconfig"

-- Function to set keymaps for diagnostics and other LSP features
local function on_attach(client, bufnr)
  nvlsp.on_attach(client, bufnr) -- Call existing on_attach from NvChad

  -- Key mapping for showing diagnostics in a floating window
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<Leader>d",
    "<Cmd>lua vim.diagnostic.open_float()<CR>",
    { noremap = true, silent = true }
  )
end

-- Configure all servers
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach, -- Use the modified on_attach function
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- Configure diagnostic display rules (optional)
vim.diagnostic.config {
  virtual_text = false, -- Disable virtual text for a cleaner appearance
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = true, -- Show the source in diagnostics
  },
}
