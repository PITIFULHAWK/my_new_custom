-- ./lua/configs/lspconfig.lua
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"
local capabilities = vim.tbl_deep_extend("force", nvlsp.capabilities, {
  textDocument = {
    implementation = {
      dynamicRegistration = true,
    },
  },
})

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

  -- Add implementation keybinding
  vim.keymap.set("n", "gI", vim.lsp.buf.implementation, bufopts)

  -- Add references keybinding (replacing gr)
  vim.keymap.set("n", "gR", vim.lsp.buf.references, bufopts)

  -- Auto-format on save
  if client:supports_method "textDocument/formatting" then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format { async = false }
      end,
      desc = "Auto format on save",
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
    capabilities = capabilities,
  }

  -- Add specific configuration for Java
  if lsp == "jdtls" then
    config.settings = {
      java = {
        signatureHelp = { enabled = true },
        contentProvider = { preferred = "fernflower" },
        implementationsCodeLens = { enabled = true },
        referencesCodeLens = { enabled = true },
        references = { includeDecompiledSources = true },
        format = {
          enabled = true,
          settings = {
            url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
            profile = "GoogleStyle",
          },
        },
        completion = {
          favoriteStaticMembers = {
            "org.hamcrest.MatcherAssert.assertThat",
            "org.hamcrest.Matchers.*",
            "org.hamcrest.CoreMatchers.*",
            "org.junit.jupiter.api.Assertions.*",
            "java.util.Objects.requireNonNull",
            "java.util.Objects.requireNonNullElse",
            "org.mockito.Mockito.*",
          },
          filteredTypes = {
            "com.sun.*",
            "io.micrometer.shaded.*",
            "java.awt.*",
            "jdk.*",
            "sun.*",
          },
        },
        sources = {
          organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
          },
        },
        codeGeneration = {
          toString = {
            template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
          },
          useBlocks = true,
        },
        configuration = {
          updateBuildConfiguration = "interactive",
          runtimes = {
            {
              name = "JavaSE-23",
              path = "/home/linuxbrew/.linuxbrew/opt/openjdk@23",
            },
          },
        },
        maven = {
          downloadSources = true,
        },
        implementationsCodeLens = {
          enabled = true,
        },
        referencesCodeLens = {
          enabled = true,
        },
      },
    }
  end

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
vim.diagnostic.config {
  virtual_text = {
    prefix = "●",
    spacing = 4,
    source = false,
    format = function(diagnostic)
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
    source = true,
    header = "",
    prefix = "",
    width = 60,
    max_width = 60,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}
