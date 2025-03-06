-- Load defaults (i.e., lua_lsp)
-- ./lua/configs/lspconfigs.lua

require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

-- Updated server list with React Native specific servers
local servers = {
  -- JavaScript/TypeScript
  "ts_ls", -- TypeScript/JavaScript server
  "eslint", -- ESLint
  "tailwindcss", -- For styling
  "cssls", -- CSS
  "jsonls", -- JSON

  -- React Native specific
  "flow", -- Flow type checker
  "sourcery", -- Advanced code analysis

  -- Keep your existing servers
  "html",
  "pyright",
  "jdtls",
  "clangd",
  "bashls",
  "yamlls",
  "dockerls",
  "terraformls",
  "prismals",
  "lua_ls",
  "rust_analyzer",
}

-- Enhanced on_attach function with React Native specific features
local function on_attach(client, bufnr)
  nvlsp.on_attach(client, bufnr)

  -- Common LSP keybindings
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "<Leader>d", vim.diagnostic.open_float, bufopts)
  vim.keymap.set("n", "<Leader>gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)

  -- React Native specific keybindings
  vim.keymap.set("n", "<Leader>rn", ":ReactNativeRun<CR>", bufopts)
  vim.keymap.set("n", "<Leader>rl", ":ReactNativeLogs<CR>", bufopts)
  vim.keymap.set("n", "<Leader>rd", ":ReactNativeDevMenu<CR>", bufopts)

  -- Auto-format on save for JavaScript/TypeScript files
  if client.name == "ts_ls" then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format { async = false }
      end,
    })
  end
end

-- TypeScript/JavaScript specific settings
local function get_typescript_settings()
  return {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
      },
    },
  }
end

-- Configure servers with specific settings
for _, lsp in ipairs(servers) do
  local config = {
    on_attach = on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }

  -- Add specific configurations for different servers
  if lsp == "ts_ls" then
    config.settings = get_typescript_settings()
    config.root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json")
    config.single_file_support = true
    config.filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    }
  elseif lsp == "eslint" then
    config.settings = {
      workingDirectory = { mode = "auto" },
      format = true,
      validate = "on",
    }
  elseif lsp == "tailwindcss" then
    config.filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "css",
    }
  end

  lspconfig[lsp].setup(config)
end

-- Configure diagnostic display
vim.diagnostic.config {
  virtual_text = {
    prefix = "●",
    spacing = 4,
    source = "always",
  },
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}

-- Set up diagnostic signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
