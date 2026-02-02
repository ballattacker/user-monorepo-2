-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  -- theme = "dark_horizon",
  -- theme = "doomchad",
  -- theme = "eldritch",
  -- theme = "everblush",
  -- theme = "gatekeeper",
  -- theme = "hiberbee",
  theme = "horizon",
  -- theme = "kanagawa",
  -- theme = "nightowl",
  -- theme = "oceanic-next",
  -- theme = "onedark",
  -- theme = "palenight",
  -- theme = "pastelDark",
  -- theme = "tokyonight",
  -- theme = "vesper",
  transparency = true,

  hl_add = {
    ["FgBase00"] = { fg = "base00" },
    ["FgBase01"] = { fg = "base01" },
    ["FgBase02"] = { fg = "base02" },
    ["FgBase03"] = { fg = "base03" },
    ["FgBase04"] = { fg = "base04" },
    ["FgBase05"] = { fg = "base05" },
    ["FgBase06"] = { fg = "base06" },
    ["FgBase07"] = { fg = "base07" },
    ["FgBase08"] = { fg = "base08" },
    ["FgBase09"] = { fg = "base09" },
    ["FgBase0A"] = { fg = "base0A" },
    ["FgBase0B"] = { fg = "base0B" },
    ["FgBase0C"] = { fg = "base0C" },
    ["FgBase0D"] = { fg = "base0D" },
    ["FgBase0E"] = { fg = "base0E" },
    ["FgBase0F"] = { fg = "base0F" },
  },
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
