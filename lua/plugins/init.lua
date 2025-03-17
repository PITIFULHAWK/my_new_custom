-- ./lua/plugins/init.lua
return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- rust installation
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client, bufnr)
            -- Customize on_attach if needed
          end,
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
              },
              completion = {
                fullFunctionSignatures = false, -- Disables long function signatures
                postfix = { enable = false },   -- Disables postfix completions if they feel excessive
              },
              diagnostics = {
                disabled = { "unresolved-proc-macro" }, -- Optional: Suppress macro-related false positives
              },
            },
          },
        },
      }
    end,
  },

  -- Enhanced JavaScript/TypeScript support
  {
    "styled-components/vim-styled-components",
    branch = "main",
    ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
  },

  -- Mason for additional tools
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "black",
        "prettier",
        "prettierd",
        "clang-format",
        "eslint_d",
        "eslint-lsp",
        "prettierd",
        "tailwindcss-language-server",
        "typescript-language-server",
        "react-native-tools",
        "flow-language-server",
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
          "vim",
          "vimdoc",
        },
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },

  -- NvimTree as file explorer (VS Code sidebar equivalent)
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
          side = "right", -- VS Code has file explorer on the left
          preserve_window_proportions = true,
        },
        filters = {
          dotfiles = false,
        },
        on_attach = function(bufnr)
          local api = require "nvim-tree.api"
          api.config.mappings.default_on_attach(bufnr)
        end,
      }
    end,
    config = function(_, opts)
      require("nvim-tree").setup(opts)
      -- Auto open nvim-tree when starting Neovim (like VS Code)
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          require("nvim-tree.api").tree.toggle { focus = false }
        end,
      })
    end,
  },

  -- Telescope for fuzzy finding (VS Code's Ctrl+P)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup {
        defaults = {
          file_ignore_patterns = { "node_modules", ".git" },
          mappings = {
            i = {
              ["<C-q>"] = require("telescope.actions").close,
            },
          },
        },
      }
      -- VS Code-like keybindings
      vim.api.nvim_set_keymap("n", "<C-p>", ":Telescope find_files<CR>", { noremap = true, silent = true }) -- Ctrl+p to find files
      vim.api.nvim_set_keymap("n", "<C-f>", ":Telescope live_grep<CR>", { noremap = true, silent = true })  -- Ctrl+f to search in files
    end,
  },

  -- Integrated terminal (VS Code's terminal)
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup {
        open_mapping = "<A-t>",
        direction = "float",
        float_opts = {
          border = "curved",
        },
      }
    end,
  },

  -- scroll behavior
  -- {
  --   "karb94/neoscroll.nvim",
  --   config = function()
  --     require("neoscroll").setup {
  --       -- Customize scroll behavior
  --       easing_function = "quadratic", -- smooth scrolling effect
  --     }
  --   end,
  -- },

  -- Completion engine (VS Code's IntelliSense)
  -- Replace your current nvim-cmp config with this:
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",   -- Buffer completions
      "hrsh7th/cmp-path",     -- Path completions
      "hrsh7th/cmp-nvim-lsp", -- LSP completions
    },
    config = function()
      local cmp = require "cmp"

      -- Setup custom formatting to fix wide completion items
      local compare = require "cmp.config.compare"
      local types = require "cmp.types"

      cmp.setup {
        window = {
          completion = {
            border = "rounded",
            winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
            scrollbar = false,
            -- Fixed width configuration
            col_offset = -3,
            side_padding = 0,
          },
          documentation = {
            border = "rounded",
            max_width = 50,
            max_height = 10,
          },
        },

        formatting = {
          fields = { "abbr", "kind", "menu" },
          format = function(entry, vim_item)
            -- Set a fixed width for the abbr field (the suggestion text)
            local abbr = vim_item.abbr
            if #abbr > 30 then
              vim_item.abbr = string.sub(abbr, 1, 27) .. "..."
            end

            -- You can customize the appearance of the menu items here
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]

            return vim_item
          end,
        },

        mapping = cmp.mapping.preset.insert {
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm { select = true },
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-d>"] = cmp.mapping.scroll_docs(3),
          ["<C-u>"] = cmp.mapping.scroll_docs(-3),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif vim.fn.col "." == 1 then -- At start of the line
              -- Insert tab character or spaces (depending on expandtab setting)
              vim.api.nvim_put({ vim.api.nvim_replace_termcodes("<Tab>", true, true, true) }, "c", true, true)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        },

        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        },

        experimental = {
          ghost_text = false,
        },

        sorting = {
          priority_weight = 2,
          comparators = {
            compare.exact,
            compare.score,
            compare.recently_used,
            compare.locality,
            compare.kind,
            compare.sort_text,
            compare.length,
            compare.order,
          },
        },
      }
    end,
  },

  -- Git integration (VS Code's git features)
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "-" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          -- Navigation
          vim.keymap.set("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, buffer = bufnr })
          vim.keymap.set("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, buffer = bufnr })
        end,
      }
    end,
  },

  -- Trouble for error panel (VS Code's Problems panel)
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup {
        position = "bottom",
        height = 10,
        icons = true,
        mode = "workspace_diagnostics",
      }
      -- Toggle trouble with Ctrl+Shift+M (like VS Code's problems panel)
      vim.api.nvim_set_keymap("n", "<C-S-m>", ":TroubleToggle<CR>", { noremap = true, silent = true })
    end,
  },

  -- Minimal statusline (for essential info without bloat)
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup {
        options = {
          theme = "auto",
          section_separators = "",
          component_separators = "|",
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      }
    end,
  },

  -- Bufferline for tabs (like VS Code's tabs)
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
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
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
              separator = false,
            },
          },
          padding = 1,
        },
      }
    end,
  },

  -- Auto-pair brackets (VS Code auto-closing brackets)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
    end,
  },

  -- For error messages
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup {
        presets = {
          bottom_search = true,
          command_palette = true,
          lsp_doc_border = true,
        },
        routes = {
          {
            filter = { event = "msg_show" },
            view = "mini", -- More minimal message view
          },
          {
            filter = { event = "notify", level = vim.log.levels.ERROR },
            view = "notify", -- Show error notifications
          },
        },
      }
    end,
  },

  -- Auto tag closing (for HTML/JSX)
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup {}
    end,
    event = "InsertEnter",
  },

  -- Indentation guides (like VS Code's indentation guides)
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "│",
      },
      scope = {
        enabled = false, -- Disable scope highlighting for performance
      },
    },
  },

  -- lightspeed.nvim
  {
    "ggandor/lightspeed.nvim",
    event = "VimEnter",
  },

  -- nvim-surround
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  -- mini.ai plugins
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.ai").setup {
        -- Add any custom configuration here, or leave it as default
      }
    end,
  },

  -- Required dependencies
  "nvim-tree/nvim-web-devicons", -- Icons
  "nvim-lua/plenary.nvim",       -- Required by telescope
}
