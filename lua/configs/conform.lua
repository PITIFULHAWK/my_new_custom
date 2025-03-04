local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettierd" },
    html = { "prettierd" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    json = { "prettierd" },
    prisma = { "null-ls" },
    python = { "black" },
    java = { "google-java-format" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    bash = { "shfmt" }, -- Bash
    yaml = { "yamlfmt" }, -- YAML
    markdown = { "prettierd" }, -- Markdown
    dockerfile = { "null-ls" }, -- Dockerfile
    terraform = { "prettierd" }, -- Terraform
  },

  format_on_save = {
    timeout_ms = 200,
    lsp_fallback = true,
  },
}

return options
