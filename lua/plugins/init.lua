local M = {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "klen/nvim-config-local",
    lazy = false,
    -- priority = 20,
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
    "rmagatti/auto-session",
    -- lazy = false,
    -- events = { "User ConfigLocalFinished" },
    init = function()
      -- vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
      vim.opt.sessionoptions:append { "winpos", "terminal", "folds" }

      vim.api.nvim_create_autocmd("User", {
        pattern = "ConfigLocalFinished",
        callback = function()
          require("auto-session").restore_session()
        end,
      })
    end,
    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      -- log_level = 'debug',
      post_restore_cmds = {
        function()
          require("nvim-tree.api").tree.toggle(false, true)
        end,
      },
    },
  },
}

return M
