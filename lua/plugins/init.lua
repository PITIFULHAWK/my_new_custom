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
  -- {
  --   "nvimtools/none-ls.nvim",
  --   event = "VeryLazy",
  --   opts = function()
  --     return require "configs.null-ls"
  --   end,
  -- },

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
          "html",
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
  -- Add your nvim-tree configuration here
  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      return {
        git = {
          enable = true, -- Enable git integration
          ignore = false, -- Show files ignored by .gitignore
        },
        renderer = {
          highlight_git = true, -- Highlight git-modified files
          icons = {
            show = {
              git = true, -- Show git icons
              folder = true, -- Show folder icons
              file = true, -- Show file icons
            },
          },
        },
        view = {
          width = 30, -- Width of the tree panel
          side = "left", -- Position of the tree panel (can be "left" or "right")
        },
        -- sort_by = "extension", -- Sort files by extension
        filters = {
          dotfiles = false, -- Show hidden files
        },
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

  -- autocomplete tags
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup {}
    end,
    -- Ensure it's loaded with treesitter for file types like JSX, TSX
    event = "InsertEnter",
  },

  -- for error message
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup {
        presets = {
          "default",
          "lsp_doc_border",
        },
        routes = {
          {
            filter = { event = "msg_show" },
            view = "floating", -- Show messages in a floating window
          },
          {
            filter = { event = "notify", level = vim.log.levels.ERROR },
            view = "floating", -- Show error notifications in a floating window
          },
        },
      }
    end,
  },

  -- Make sure you have these dependencies too (this is for the above error plugi
  "kyazdani42/nvim-web-devicons", -- Required for icons
}
