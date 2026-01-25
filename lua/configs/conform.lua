local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    fennel = { "fnlfmt" },
    sh = { "shfmt" },

    html = { "prettier" },
    markdown = { "deno_fmt" },

    json = { "deno_fmt" },
    yaml = { "yamlfmt" },
    toml = { "taplo" },

    javascript = { "deno_fmt" },
    javascriptreact = { "deno_fmt" },
    typescript = { "deno_fmt" },
    typescriptreact = { "deno_fmt", "rustywind" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
