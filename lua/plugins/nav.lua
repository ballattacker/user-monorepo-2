local M = {
  ---@type LazySpec
  {
    "mfussenegger/nvim-treehopper",
    -- dependencies = { "smoka7/hop.nvim" },
    init = function()
      vim.api.nvim_set_hl(0, "TSNodeUnmatched", { link = "FgBase03" })
      vim.api.nvim_set_hl(0, "TSNodeKey", { link = "FgBase08" })
    end,
    keys = {
      {
        "on",
        function()
          require("tsht").nodes()
        end,
        desc = "Treehopper - operate node",
        mode = { "o" },
        silent = true,
      },
      {
        "on",
        [[:lua require("tsht").nodes()<CR>]],
        desc = "Treehopper - select node",
        mode = { "x" },
        silent = true,
      },
    },
  },

  -- NOTE: should we use hydra?
  {
    "drybalka/tree-climber.nvim",
    keys = (function()
      local map = function(lhs, action)
        return {
          lhs,
          function()
            require("tree-climber")[action] {
              highlight = true,
              higroup = "CursorColumn",
            }
          end,
          noremap = true,
          silent = true,
        }
      end
      return {
        map("gh", "goto_parent"),
        map("gl", "goto_child"),
        map("gj", "goto_next"),
        map("gk", "goto_prev"),
      }
    end)(),
  },

  {
    "smoka7/hop.nvim",
    opts = {
      keys = "etovxqpdygfblzhckisuran",
      extension = { "plugins.hop.nodes" },
    },
    keys = {
      {
        "sn",
        function()
          local hop = require "hop"
          local hop_nodes = require "configs.hop.nodes"
          hop_nodes.register(hop.opts)
          hop_nodes.named_nodes()
        end,
        remap = true,
      },
      {
        "sg",
        function()
          local hop = require "hop"
          hop.hint_with(function(_opts)
            -- local jump_targets = {
            --   { window = 0, buffer = 0, cursor = { row = 1, col = 14 }, length = 1 },
            --   { window = 0, buffer = 0, cursor = { row = 2, col = 1 }, length = 1 },
            -- }
            local jump_targets = {}
            local min_x_distance = 10
            -- local min_y_distance = 5
            for i = 1, vim.api.nvim_buf_line_count(0) do
              local line = vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1]
              local start_col = line:find "%S" or 1
              local end_col = #line
              for j = start_col, end_col, min_x_distance do
                table.insert(jump_targets, {
                  window = 0,
                  buffer = 0,
                  cursor = { row = i, col = j - 1 },
                  length = 1,
                })
              end
            end
            return {
              jump_targets = jump_targets,
            }
          end, hop.opts)
        end,
        remap = true,
      },
    },
  },
}

return M
