require "utils"

local M = {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = true,
      indent = {
        enable = true,
        disable = {
          "python",
        },
      },
    },
  },
}

local auto = {
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
      max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = "-",
      zindex = 20, -- The Z-index of the context window
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    },
  },

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },

  {
    "NMAC427/guess-indent.nvim",
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function(_, _)
      -- This module contains a number of default definitions
      local rainbow_delimiters = require "rainbow-delimiters"

      ---@type rainbow_delimiters.config
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        priority = {
          [""] = 110,
          lua = 210,
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          -- "RainbowDelimiterOrange",
          -- "RainbowDelimiterGreen",
          -- "RainbowDelimiterViolet",
          -- "RainbowDelimiterCyan",
        },
      }
    end,
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}

for _, p in ipairs(auto) do
  p.event = {
    "BufReadPre",
    "BufNewFile",
  }
end

table.push(M, auto)

return M
