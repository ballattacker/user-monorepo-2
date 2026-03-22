local M = {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()

      -- only specify for frequently opened single file language
      -- or common/system servers
      local servers = {
        "lua_ls",
        "bashls", -- need shellcheck, shfmt
        "yamlls",
        "taplo", -- toml
        "html",
        "ts_ls",
      }

      vim.lsp.enable(servers)
    end,
  },

  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
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
    },
    keys = {
      {
        "<leader>fm",
        function()
          require("conform").format()
        end,
        desc = "general format file",
        mode = { "n", "v" },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    config = function()
      local lint = require "lint"
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      lint.linters_by_ft = {
        sh = { "shellcheck" },
      }
    end,
  },

  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    event = "LspAttach",
    keys = {
      {
        "gra",
        function()
          require("tiny-code-action").code_action({})
        end,
        mode = { "n", "x" },
        desc = "tiny-code-action.code_action()",
        noremap = true,
        silent = true,
      },
    },
  },
}

return M
