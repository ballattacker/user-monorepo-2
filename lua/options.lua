require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

vim.opt.shell = "/usr/bin/zsh"

vim.opt.timeout = false

vim.opt.list = true
vim.opt.listchars = {
  tab = " ",
  trail = "█",
  extends = "",
  precedes = "",
  nbsp = "○",
  eol = "↲",
  -- leadmultispace = "│ ",
} -- alternative: … ␣ · ◣ ◢ ↲ ↵    󰌒

vim.opt.wrap = false
vim.opt.virtualedit = "all"
vim.opt.whichwrap = "b,s,[]"

-- https://stackoverflow.com/a/16114535
vim.opt.fixeol = false

-- https://stackoverflow.com/questions/2295410/how-to-prevent-the-cursor-from-moving-back-one-character-on-leaving-insert-mode#comment11302803_2296229
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = ":normal! `^",
})

-- https://www.reddit.com/r/neovim/comments/sqld76/stop_automatic_newline_continuation_of_comments/
-- vim.opt.formatoptions:remove { "c", "r", "o" }
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
})

vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})
