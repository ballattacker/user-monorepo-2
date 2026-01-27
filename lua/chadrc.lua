-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "kanagawa",
  transparency = true,

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

M.ui = {
  tabufline = {
    lazyload = false,
  },

  statusline = {
    theme = "vscode_colored",
    separator_style = "default",
    modules = {
      file = function()
        local icon = "󰈚"
        local path = (vim.fn.expand "%" == "" and "Empty") or vim.fn.expand "%:." -- relative path
        local name = (path == "" and "Empty") or path:match "([^/\\]+)[/\\]*$"

        if name ~= "Empty" then
          local devicons_present, devicons = pcall(require, "nvim-web-devicons")

          if devicons_present then
            local ft_icon = devicons.get_icon(name)
            icon = (ft_icon ~= nil and ft_icon) or icon
          end
        end

        return table.concat({ "%#StText#", icon, path, "" }, " ")
      end,
    },
  },
}

M.term = {
  float = {
    row = 0.2,
    col = 0.0,
    width = 1.0,
    height = 0.6,
  },
}

M.colorify = {
  mode = "bg", -- fg, bg, virtual
}

M.nvdash = {
  load_on_startup = true,
}

return M
