-- https://stackoverflow.com/a/326715
function os.exec(cmd, opts)
  opts = opts or {}
  if opts.trim == nil then
    opts.trim = false
  end
  if opts.silent == nil then
    opts.silent = true
  end

  if opts.silent then
    cmd = cmd .. " >/dev/null 2>&1"
  end

  local f = assert(io.popen(cmd, "r"))
  local s = assert(f:read "*a")
  f:close()

  if opts.trim then
    s = string.gsub(s, "^%s+", "")
    s = string.gsub(s, "%s+$", "")
    s = string.gsub(s, "[\n\r]+", " ")
  end

  return s
end
