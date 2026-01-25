require "utils"

local M = {
  {
    "klen/nvim-config-local",
    lazy = false,
    -- priority = 60,
    config = function()
      vim.g.config_local = {}
      require("config-local").setup {
        -- Default configuration (optional)
        config_files = { ".vimrc", ".nvim/init.lua" }, -- Config file patterns to load (lua supported)
        hashfile = vim.fn.stdpath "data" .. "/config-local", -- Where the plugin keeps files data
        autocommands_create = true, -- Create autocommands (VimEnter, DirectoryChanged)
        commands_create = true, -- Create commands (ConfigSource, ConfigEdit, ConfigTrust, ConfigIgnore)
        silent = false, -- Disable plugin messages (Config loaded/ignored)
        lookup_parents = false, -- Lookup config files in parent directories
      }
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = require "configs.tree",
  },

  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },

  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
  },

  {
    "mrjones2014/legendary.nvim",
    version = "v2.13.9",
    -- since legendary.nvim handles all your keymaps/commands,
    -- its recommended to load legendary.nvim before other plugins
    priority = 10000,
    lazy = false,
    -- sqlite is only needed if you want to use frecency sorting
    -- dependencies = { 'kkharji/sqlite.lua' }
  },
}

table.push(M, require "plugins.git")
table.push(M, require "plugins.lsp")
table.push(M, require "plugins.cmp")
table.push(M, require "plugins.syntax")
table.push(M, require "plugins.ft")

return M
