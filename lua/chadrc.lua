-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "bearded-arc",

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
    -- https://nvchad.com/docs/config/nvchad_ui#override_statusline_modules
    -- https://github.com/NvChad/ui/blob/6c22f52568c4ab080a6676f7bb6515f0076e6567/lua/nvchad/statusline/vscode_colored.lua#L55
    overriden_modules = function(modules)
      modules[2] = (function()
        local fn = vim.fn
        local icon = " 󰈚 "
        local filename = (fn.expand "%" == "" and "Empty ") or fn.expand "%:." -- relative path

        if filename ~= "Empty " then
          local devicons_present, devicons = pcall(require, "nvim-web-devicons")

          if devicons_present then
            local ft_icon = devicons.get_icon(filename)
            icon = (ft_icon ~= nil and " " .. ft_icon) or ""
          end

          filename = " " .. filename .. " "
        end

        return "%#StText# " .. icon .. filename
      end)()
    end,
  },
}

M.colorify = {
  mode = "bg", -- fg, bg, virtual
}

M.nvdash = {
  load_on_startup = true,
}

return M
