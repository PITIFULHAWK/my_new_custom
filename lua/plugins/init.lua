return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
  --
  -- Mason for additional tools
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "black",
        "prettierd",
        "clang-format",
        "eslint_d",
        "eslint-lsp",
        "prettierd",
        "tailwindcss-language-server",
        "typescript-language-server",
        "prisma-language-server",
        "pyright",
        "jdtls",
        "clangd",
        "bash-language-server",
        "yaml-language-server",
        "dockerfile-language-server",
        "terraform-ls",
        "json-lsp",
        "css-lsp",
      },
    },
  },

  -- none-ls for null-ls configuration
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "configs.null-ls"
    end,
  },

  -- Treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      return {
        ensure_installed = {
          "lua",
          "javascript",
          "typescript",
          "tsx",
          "prisma",
          "python",
          "java",
          "c",
          "cpp",
          "bash",
          "yaml",
          "json",
          "dockerfile",
          "hcl",
          "css",
        },
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },
  -- scroll behavior
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup {
        -- Customize scroll behavior
        easing_function = "quadratic", -- smooth scrolling effect
      }
    end,
  },
}
