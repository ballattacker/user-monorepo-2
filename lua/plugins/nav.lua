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
}

return M
