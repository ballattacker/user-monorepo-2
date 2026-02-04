local M = {
  {
    "nvim-tree/nvim-tree.lua",
    opts = require "configs.tree",
  },

  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    cmd = "Oil",
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            ["<C-d>"] = "preview_scrolling_down",
            ["<C-u>"] = "preview_scrolling_up",
            ["<C-h>"] = function()
              vim.api.nvim_input "<C-w>"
            end,
            ["<C-l>"] = "select_default",
            ["<C-m>"] = "select_default",
          },
        },
      },
    },
  },

  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
  },

  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
}

return M
