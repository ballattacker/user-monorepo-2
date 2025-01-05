-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = {
  "html",
  "cssls",
  "ts_ls",
  "tailwindcss",
  "taplo",
}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

lspconfig.fennel_language_server.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  -- https://miguelcrespo.co/posts/configuring-neovim-with-fennel/
  settings = {
    fennel = {
      workspace = {
        -- If you are using hotpot.nvim or aniseed,
        -- make the server aware of neovim runtime files.
        library = vim.api.nvim_list_runtime_paths(),
        checkThirdParty = false, -- THIS IS THE IMPORTANT LINE TO ADD
      },
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}

-- https://github.com/creativenull/efmls-configs-nvim

local shellcheck = require "efmls-configs.linters.shellcheck"
local languages = {
  sh = { shellcheck },
}

-- Or use the defaults provided by this plugin
-- check doc/SUPPORTED_LIST.md for the supported languages
--
-- local languages = require("efmls-configs.defaults").languages()

lspconfig.efm.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = vim.tbl_keys(languages),
  settings = {
    rootMarkers = { ".git/" },
    languages = languages,
  },
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
}
