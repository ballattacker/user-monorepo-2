require "nvchad.mappings"

vim.keymap.del({ "n" }, "<tab>")
vim.keymap.del({ "n" }, "<S-tab>")
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

vim.keymap.set({ "t" }, "<esc>", "<C-\\><C-n>")

vim.keymap.set({ "i" }, "<C-h>", "<C-w>")

-- these mappings kind of suck actually

vim.keymap.set({ "n", "v" }, "D", '"_d')
vim.keymap.set({ "n", "v" }, "C", '"_c')

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
