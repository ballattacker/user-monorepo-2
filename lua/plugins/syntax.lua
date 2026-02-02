require "utils"

local M = {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    main = "nvim-treesitter.configs",
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      require("nvim-treesitter.install").prefer_git = true
      require("nvim-treesitter.install").compilers = { "zig" }
    end,
    opts = {
      auto_install = true,
      highlight = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
      },
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

  -- {
  --   "JoosepAlviste/nvim-ts-context-commentstring",
  -- },

  {
    "NMAC427/guess-indent.nvim",
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function(_, opts)
      require("rainbow-delimiters.setup").setup(opts)

      vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { link = "Base46FgRed" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { link = "Base46FgOrange" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { link = "Base46FgYellow" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { link = "Base46FgGreen" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { link = "Base46FgCyan" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { link = "Base46FgBlue" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { link = "Base46FgPurple" })
    end,
    opts = {
      highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
      },
    },
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
