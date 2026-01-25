require("nvchad.configs.lspconfig").defaults()

-- only specify for frequently opened single file language
-- or common/system servers
local servers = {
  -- "bashls", -- need shellcheck, shfmt
  -- "efm", -- general purpose
  "fennel_language_server",
  "yamlls",
  "taplo", -- toml
  "html",
  "ts_ls",
}

vim.lsp.enable(servers)
