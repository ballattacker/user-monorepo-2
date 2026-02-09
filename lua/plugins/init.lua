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

      -- local session_name = "default"
      -- local session_dir = vim.fs.joinpath(vim.fn.getcwd(), ".nvim", "sessions")
      -- if vim.fn.isdirectory(session_dir) == 0 then
      --   vim.fn.mkdir(session_dir, "p")
      -- end
      -- local gitignore_path = vim.fs.joinpath(session_dir, ".gitignore")
      -- if vim.fn.filereadable(gitignore_path) == 0 then
      --   vim.fn.writefile({ "*" }, gitignore_path)
      -- end
      -- local session_path = vim.fs.joinpath(session_dir, session_name .. ".vim")
      -- vim.api.nvim_create_autocmd("User", {
      --   pattern = "ConfigLocalFinished",
      --   callback = function()
      --     if vim.fn.filereadable(session_path) == 1 then
      --       vim.cmd("source " .. session_path)
      --       print("Session loaded: " .. session_name)
      --     end
      --   end,
      -- })
      -- vim.api.nvim_create_autocmd("VimLeave", {
      --   pattern = "*",
      --   callback = function()
      --     vim.cmd("mksession! " .. vim.fs.joinpath(session_dir, session_name .. ".vim"))
      --   end,
      -- })
    end,
  },

  {
    "Shatur/neovim-session-manager",
    init = function()
      vim.api.nvim_create_autocmd("VeryLazy", {
        pattern = "*",
        callback = function()
          require("session_manager").load_current_dir_session()
        end,
      })
    end,
    event = { "BufReadPre", "User ConfigLocalFinished" },
    -- event = { "BufReadPre", "VeryLazy" },
    config = function()
      require("session_manager").setup {
        autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
      }
      -- Show nvim-tree on session load
      vim.api.nvim_create_autocmd("User", {
        pattern = "SessionLoadPost",
        callback = function()
          require("nvim-tree.api").tree.toggle(false, true)
        end,
      })
    end,
  },
}

return M
