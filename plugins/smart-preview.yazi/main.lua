--- @since 25.5.31
--- @sync entry

local function entry(self)
  local h = cx.active.current.hovered
  if h and h.cha.is_dir then
    ya.emit("enter", { hovered = true })
  else
    ya.emit("shell", { [[ preview-less.sh "$0" ]], block = true })
  end
end

return { entry = entry }
