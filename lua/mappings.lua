require "nvchad.mappings"
require "utils"

vim.keymap.del({ "n" }, "<tab>")
vim.keymap.del({ "n" }, "<S-tab>")
vim.keymap.del({ "n" }, "<leader>b")
vim.keymap.del({ "n" }, "<leader>e")
vim.keymap.del({ "n" }, "<leader>h")
vim.keymap.del({ "n" }, "<leader>v")

vim.keymap.set({ "n", "v", "o" }, "a", "<Nop>")
vim.keymap.set({ "n" }, "A", "<Nop>")
vim.keymap.set({ "n", "v", "o" }, "o", "a")
vim.keymap.set({ "n" }, "O", "A")

vim.keymap.set({ "n", "v", "o" }, "sh", "^")
vim.keymap.set({ "n", "v", "o" }, "sl", "$")

vim.keymap.set({ "n", "v" }, "<C-h>", "6h")
vim.keymap.set({ "n", "v" }, "<C-j>", "3j")
vim.keymap.set({ "n", "v" }, "<C-k>", "3k")
vim.keymap.set({ "n", "v" }, "<C-l>", "6l")

-- these mappings kind of suck actually

vim.keymap.set({ "t" }, "<esc>", "<C-\\><C-n>")

vim.keymap.set({ "n", "v" }, "D", '"_d')
vim.keymap.set({ "n", "v" }, "C", '"_c')
vim.keymap.set({ "n", "v" }, "U", "<C-r>")

-- navigation
vim.keymap.set({ "n" }, "eh", function()
  require("nvchad.tabufline").prev()
end)
vim.keymap.set({ "n" }, "el", function()
  require("nvchad.tabufline").next()
end)
vim.keymap.set({ "n" }, "ew", ":w<cr>")
vim.keymap.set({ "n" }, "eq", function()
  require("nvchad.tabufline").close_buffer()
end)
vim.keymap.set({ "n" }, "eQ", ":quitall!<cr>")
vim.keymap.set({ "n" }, "ex", function()
  require("nvchad.tabufline").closeAllBufs(false)
end)
vim.keymap.set({ "n" }, "<C-w>e", function()
  require("nvim-tree.api").tree.focus()
end)
vim.keymap.set({ "n" }, "<C-w><C-e>", function()
  require("nvim-tree.api").tree.focus()
end)

vim.keymap.set({ "n" }, "<leader>i", function()
  vim.lsp.buf.hover()
end, { desc = "lsp hover" })
vim.keymap.set({ "n", "v" }, "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "general format file" })

-- git
vim.keymap.set({ "n" }, "<leader>gacm", function()
  local msg = vim.fn.input "Commit message: "
  if msg and msg ~= "" then
    os.exec(string.format("git add --all && git commit -m '%s'", msg))
  else
    print "Commit aborted: No commit message provided."
  end
end, { desc = "git add commit" })
vim.keymap.set({ "n" }, "<leader>gacp", function()
  local msg = vim.fn.input "Commit message (push): "
  if msg and msg ~= "" then
    os.exec(string.format("git add --all && git commit -m '%s' && git push", msg))
  else
    print "Commit aborted: No commit message provided."
  end
end, { desc = "git add commit push" })

vim.keymap.set({ "n" }, "sf", function()
  require("hop").hint_char1()
end, { desc = "HopChar1" })

vim.keymap.set({ "n" }, "<leader>hxi", function()
  require("hex").dump()
end, { desc = "Edit in hex on" })
vim.keymap.set({ "n" }, "<leader>hxo", function()
  require("hex").assemble()
end, { desc = "Edit in hex off" })
