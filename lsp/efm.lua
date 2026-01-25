-- https://github.com/creativenull/efmls-configs-nvim

local shellcheck = require "efmls-configs.linters.shellcheck"
local languages = {
  sh = { shellcheck },
}

-- Or use the defaults provided by this plugin
-- check doc/SUPPORTED_LIST.md for the supported languages
--
-- local languages = require("efmls-configs.defaults").languages()

return {
  filetypes = vim.tbl_keys(languages),
  settings = {
    rootMarkers = { ".git/" },
    languages = languages,
  },
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
    hover = true,
    documentSymbol = true,
    codeAction = true,
    codeCompletion = true,
  },
}
