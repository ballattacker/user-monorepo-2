require("nvchad.configs.lspconfig").defaults()

-- only specify for frequently opened single file language
-- or common/system servers
local servers = {
  "efm", -- general purpose -- for shell
  "fennel_language_server",
  "html",
  "ts_ls",
  "taplo", -- toml
}

vim.lsp.enable(servers)
