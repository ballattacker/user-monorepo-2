require "utils"

local M = {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = require "configs.tree",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.treesitter",
  },

  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    opts = {
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
        delay = 0,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
      },
    },
  },

  -- {
  -- 	"NvChad/nvterm",
  -- 	opts = overrides.nvterm,
  -- },
  --
  -- {
  -- 	"nvim-telescope/telescope.nvim",
  -- 	opts = overrides.telescope,
  -- },

  {
    "smoka7/hop.nvim",
    version = "v2", -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      -- require'hop'.setup { keys = 'lsahgieowpqnvmcurkdjf' }
      require("hop").setup { keys = "eiwosla;mcvnqpjfkd" }
    end,
  },

  {
    "NMAC427/guess-indent.nvim",
    lazy = false,
    config = function()
      require("guess-indent").setup {}
    end,
  },

  {
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
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
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    lazy = false,
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

	-- {
	-- 	"NeogitOrg/neogit",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim", -- required
	-- 		"sindrets/diffview.nvim", -- optional - Diff integration
	--
	-- 		-- Only one of these is needed, not both.
	-- 		"nvim-telescope/telescope.nvim", -- optional
	-- 		-- "ibhagwan/fzf-lua", -- optional
	-- 	},
	-- 	config = true,
	-- 	cmd = "Neogit",
	-- },

	{
		"RaafatTurki/hex.nvim",
		config = function(_, _)
			require("hex").setup()
		end,
	},

	{
		"gpanders/nvim-parinfer",
		ft = { "lisp" },
	},
}

table.push(M, require "plugins.cmp")

return M
