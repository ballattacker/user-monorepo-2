require "nvchad.mappings"

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

vim.keymap.set({ "n" }, "eQ", ":quitall!<cr>")
vim.keymap.set({ "n" }, "ew", ":w<cr>")

