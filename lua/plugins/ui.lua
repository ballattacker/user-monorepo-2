local M = {
  {
    "nvim-tree/nvim-tree.lua",
    opts = require "configs.tree",
  },

  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    cmd = "Oil",
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
    -- TODO: config oil
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      view_options = { show_hidden = true },
      use_default_keymaps = false,
      -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
      -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
      -- Additionally, if it is a string that matches "actions.<name>",
      -- it will use the mapping at require("oil.actions").<name>
      -- Set to `false` to remove a keymap
      -- See :help oil-actions for a list of all available actions
      keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = { "actions.close", mode = "n" },
        ["<C-l>"] = "actions.refresh",
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
      },
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

  -- {
  --   "chrisgrieser/nvim-origami",
  --   event = "VeryLazy",
  --   opts = {}, -- required even when using default config
  --   -- recommended: disable vim's auto-folding
  --   init = function()
  --     vim.opt.foldlevel = 99
  --     vim.opt.foldlevelstart = 99
  --   end,
  --   keys = {
  --     {
  --       "sh",
  --       function()
  --         require("origami").caret()
  --       end,
  --       desc = "Origami fold recursively",
  --     },
  --     {
  --       "sl",
  --       function()
  --         require("origami").dollar()
  --       end,
  --       desc = "Origami unfold recursively",
  --     },
  --   },
  -- },

  -- {
  --   "kevinhwang91/nvim-ufo",
  --   dependencies = { "kevinhwang91/promise-async" },
  --   event = "VeryLazy",
  --   opts = {
  --     provider_selector = function(bufnr, filetype, buftype)
  --       return { "treesitter", "indent" }
  --     end,
  --   },
  --   init = function()
  --     vim.o.foldcolumn = "1" -- '0' is not bad
  --     vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
  --     vim.o.foldlevelstart = 99
  --     vim.o.foldenable = true
  --   end,
  --   keys = {
  --     {
  --       "zR",
  --       function()
  --         require("ufo").openAllFolds()
  --       end,
  --       desc = "Open all folds",
  --       remap = true,
  --     },
  --     {
  --       "zM",
  --       function()
  --         require("ufo").closeAllFolds()
  --       end,
  --       desc = "Close all folds",
  --       remap = true,
  --     },
  --   },
  -- },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        ---@module 'notify'
        ---@type notify.Config
        opts = {
          merge_duplicates = true,
          render = "wrapped-compact",
          max_width = function()
            return math.floor(vim.o.columns * 0.3)
          end,
          stages = "fade",
          background_colour = "BgBase00",
        },
      },
    },
  },
}

return M
