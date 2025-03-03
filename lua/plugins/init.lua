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
          enable = true,
          ignore = false,
        },
        renderer = {
          highlight_git = true,
          icons = {
            show = {
              git = true,
              folder = true,
              file = true,
            },
          },
        },
        view = {
          width = 30,
          side = "right",
          preserve_window_proportions = true, -- Add this line
        },
        filters = {
          dotfiles = false,
        },
        on_attach = function(bufnr)
          -- Prevent any bufferline adjustments
          local api = require "nvim-tree.api"
          api.config.mappings.default_on_attach(bufnr)
        end,
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

  -- Add bufferline configuration to completely eliminate header space
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local colors = require("base46").get_theme_tb "base_30"
      local bg_color = colors.black or "#000000" -- Get your theme's background color
      require("bufferline").setup {
        options = {
          mode = "buffers",
          numbers = "none",
          indicator = { style = "none" },
          separator_style = "thin",
          show_buffer_close_icons = false,
          show_close_icon = false,
          always_show_bufferline = true,
          enforce_regular_tabs = true,
          offsets = {}, -- Remove offsets completely
          padding = 0,
        },
      }
      -- Override nvim-tree to prevent offset behavior
      local nvim_tree_events = require "nvim-tree.events"
      local bufferline_api = require "bufferline.api"
      nvim_tree_events.subscribe("TreeOpen", function()
        bufferline_api.set_offset(0) -- Force zero offset when tree opens
      end)
      nvim_tree_events.subscribe("TreeClose", function()
        bufferline_api.set_offset(0) -- Force zero offset when tree closes
      end)
    end,
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
