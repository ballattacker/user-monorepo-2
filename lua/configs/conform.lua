local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },

    javascript = { "deno_fmt" },
    javascriptreact = { "deno_fmt" },
    typescript = { "deno_fmt" },
    typescriptreact = { "deno_fmt", "rustywind" },
    json = { "deno_fmt" },

    fennel = { "fnlfmt" },
    go = { "gofmt" },
    elixir = { "mix" },
    sh = { "shfmt" },
    -- python = { "isort", "black" },
    markdown = { "deno_fmt" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
