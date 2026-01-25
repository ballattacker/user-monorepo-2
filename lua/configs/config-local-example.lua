vim.lsp.config("gopls", {})
vim.lsp.enable("gopls")

require("conform").formatters_by_ft.go = "gofmt"
require("conform").formatters.gofmt = {}
