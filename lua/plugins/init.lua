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
    config = function(_, _)
      -- https://github.com/kevinhwang91/nvim-bqf#setup-and-description
      require("bqf").setup {}
    end,
  },

  {
    "RaafatTurki/hex.nvim",
    config = function(_, _)
      require("hex").setup()

      vim.keymap.set({ "n" }, "<leader>hxi", function()
        require("hex").dump()
      end, { desc = "Edit in hex on" })
      vim.keymap.set({ "n" }, "<leader>hxo", function()
        require("hex").assemble()
      end, { desc = "Edit in hex off" })
    end,
  },

  {
    "hat0uma/csvview.nvim",
    ---@module "csvview"
    ---@type CsvView.Options
    opts = {
      parser = { comments = { "#", "//" } },
      keymaps = {
        -- Text objects for selecting fields
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        -- Excel-like navigation:
        -- Use <Tab> and <S-Tab> to move horizontally between fields.
        -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
        -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
        jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
        jump_next_row = { "<Enter>", mode = { "n", "v" } },
        jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
      },
    },
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  },

  {
    "gpanders/nvim-parinfer",
    ft = { "lisp", "fennel" },
  },

  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
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

return M
