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
}

return M
