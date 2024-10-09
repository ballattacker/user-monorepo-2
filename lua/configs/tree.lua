local function on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  -- vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
  -- vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))

  vim.keymap.set('n', 'D', '',      { buffer = bufnr })
  vim.keymap.del('n', 'D',          { buffer = bufnr })
  vim.keymap.set('n', 'd', '',      { buffer = bufnr })
  vim.keymap.del('n', 'd',          { buffer = bufnr })
  vim.keymap.set('n', 'e', '',      { buffer = bufnr })
  vim.keymap.del('n', 'e',          { buffer = bufnr })
  vim.keymap.set('n', 'p', '',      { buffer = bufnr })
  vim.keymap.del('n', 'p',          { buffer = bufnr })
  vim.keymap.set('n', 'y', '',      { buffer = bufnr })
  vim.keymap.del('n', 'y',          { buffer = bufnr })
  vim.keymap.set('n', '<C-k>', '',  { buffer = bufnr })
  vim.keymap.del('n', '<C-k>',      { buffer = bufnr })

  vim.keymap.set('n', 'l',        api.node.open.edit,                   opts('Open Preview'))
  vim.keymap.set('n', 'h',        api.node.navigate.parent_close,       opts('Close Directory'))
  vim.keymap.set('n', 'i',        api.fs.create,                        opts('Create'))
  vim.keymap.set('n', 'yy',       api.fs.copy.node,                     opts('Copy'))
  vim.keymap.set('n', 'dd',       api.fs.cut,                           opts('Cut'))
  vim.keymap.set('n', 'pp',       api.fs.paste,                         opts('Paste'))
  vim.keymap.set('n', '<C-i>',    api.node.show_info_popup,             opts('Info'))
  vim.keymap.set('n', 'Dd',       api.fs.remove,                        opts('Delete'))
end

local M = {
  on_attach = on_attach,
}

return M
