-- ./lua/configs/lspconfig.lua
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

-- Remove sourcery from servers list
local servers = {
  -- JavaScript/TypeScript
  "ts_ls", -- TypeScript/JavaScript server
  "eslint",
  "tailwindcss",
  "cssls",
  "jsonls",

  -- Your other servers
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

local function on_attach(client, bufnr)
  nvlsp.on_attach(client, bufnr)

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "<Leader>d", vim.diagnostic.open_float, bufopts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)

  -- Bun + React Native specific keybindings
  vim.keymap.set("n", "<Leader>rn", ":!bun run android<CR>", bufopts)
  vim.keymap.set("n", "<Leader>ri", ":!bun run ios<CR>", bufopts)
  vim.keymap.set("n", "<Leader>rs", ":!bun start<CR>", bufopts)
  vim.keymap.set("n", "<Leader>rt", ":!bun test<CR>", bufopts)

  -- Auto-format on save
  if client.name == "ts_ls" then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format { async = false }
      end,
    })
  end
end

-- TypeScript/JavaScript settings
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
      suggest = {
        completeFunctionCalls = true,
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
      suggest = {
        completeFunctionCalls = true,
      },
    },
  }
end

-- Configure servers
for _, lsp in ipairs(servers) do
  local config = {
    on_attach = on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }

  if lsp == "ts_ls" then
    config.settings = get_typescript_settings()
    config.root_dir = lspconfig.util.root_pattern("bun.lockb", "package.json", "tsconfig.json", "jsconfig.json")
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
-- Configure diagnostic display
vim.diagnostic.config {
  virtual_text = {
    prefix = "●",
    spacing = 4,
    source = false, -- Don't show source in virtual text
    format = function(diagnostic)
      -- Limit the diagnostic message length
      local message = diagnostic.message
      if #message > 50 then
        return string.sub(message, 1, 45) .. "..."
      end
      return message
    end,
  },
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = true, -- Show source in float window instead
    header = "",
    prefix = "",
    -- Format floating window width
    width = 60, -- Set maximum width
    max_width = 60, -- Ensure it doesn't exceed this width
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}

-- Set up diagnostic signs with the same icons
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
