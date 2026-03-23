require "nvchad.mappings"
require "utils"

-- unbind nvchad
vim.keymap.del({ "n" }, "<tab>")
vim.keymap.del({ "n" }, "<S-tab>")
vim.keymap.del({ "n" }, "<leader>b")
vim.keymap.del({ "n" }, "<leader>e")
vim.keymap.del({ "n" }, "<leader>h")
vim.keymap.del({ "n" }, "<leader>v")
vim.keymap.del({ "n" }, "<leader>x")
vim.keymap.del({ "n", "v" }, "<leader>/")

-- rebind awkward vim defaults

vim.keymap.set({ "n", "v", "o" }, "a", "<Nop>")
vim.keymap.set({ "n" }, "A", "<Nop>")
vim.keymap.set({ "n", "v", "o" }, "o", "a")
vim.keymap.set({ "n" }, "O", "A")

vim.keymap.set({ "n", "v", "o" }, "s", "<Nop>")
vim.keymap.set({ "n", "v", "o" }, "sh", "^")
vim.keymap.set({ "n", "v", "o" }, "sl", "$")
vim.keymap.set({ "n" }, "sO", "o")
vim.keymap.set({ "n" }, "sI", "O")

vim.keymap.set({ "n", "v", "o" }, "b", "<Nop>")
vim.keymap.set({ "n", "v", "o" }, "B", "<Nop>")
vim.keymap.set({ "n", "v", "o" }, "e", "w")
vim.keymap.set({ "n", "v", "o" }, "E", "W")
vim.keymap.set({ "n", "v", "o" }, "w", "b")
vim.keymap.set({ "n", "v", "o" }, "W", "B")

-- movement
vim.keymap.set({ "n", "v" }, "<C-h>", "6h")
vim.keymap.set({ "n", "v" }, "<C-j>", "3j")
vim.keymap.set({ "n", "v" }, "<C-k>", "3k")
vim.keymap.set({ "n", "v" }, "<C-l>", "6l")

vim.keymap.set({ "n", "v" }, "D", '"_d')
vim.keymap.set({ "n", "v" }, "C", '"_c')
vim.keymap.set({ "n" }, "U", "<C-r>")
vim.keymap.set({ "n" }, "<C-r>", "<C-l>")

vim.keymap.set({ "t" }, "<esc>", "<C-\\><C-n>")

-- follow spacemacs conventions

-- files
vim.keymap.set("n", "<leader>fs", "<cmd>w<cr>", { desc = "Save" })
vim.keymap.set("n", "<leader>fS", "<cmd>wa<cr>", { desc = "Save All Files" })
vim.keymap.set("n", "<leader>ft", function()
  require("nvim-tree.api").tree.toggle()
end, { desc = "File Tree" })
vim.keymap.set("n", "<leader>fT", function()
  require("nvim-tree.api").tree.focus()
end, { desc = "Focus File Tree" })

-- buffers
-- TODO: stop using nvchad buffers
vim.keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<cr>", { desc = "Switch Buffer" })
-- vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>bd", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Kill Buffer" })
vim.keymap.set("n", "<leader>b<C-d>", function()
  require("nvchad.tabufline").closeAllBufs(false)
end, { desc = "Kill Other Buffers" })
-- not using spacemacs bindings
-- vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next Buffer" })
-- vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>bl", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bh", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
-- shortened
vim.keymap.set("n", "bb", "<cmd>Telescope buffers<cr>", { desc = "Switch Buffer" })
vim.keymap.set("n", "bd", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Kill Buffer" })
vim.keymap.set("n", "b<C-d>", function()
  require("nvchad.tabufline").closeAllBufs(false)
end, { desc = "Kill Other Buffers" })
vim.keymap.set("n", "bl", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "bh", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })

-- windows
-- not really useful but for completion sake
vim.keymap.set("n", "<leader>ws", "<cmd>split<cr>", { desc = "Split Horizontal" })
vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Split Vertical" })
vim.keymap.set("n", "<leader>wd", "<cmd>close<cr>", { desc = "Delete Window" })
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Go Left" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Go Down" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Go Up" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Go Right" })

-- session
vim.keymap.set("n", "<leader>qs", "<cmd>xa<cr>", { desc = "Save and Quit" })
vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })
vim.keymap.set("n", "<leader>qQ", "<cmd>qa!<cr>", { desc = "Quit Without Saving" })

-- lsp
-- not all of them yet
-- vim.keymap.set({ "n", "x" }, "<leader>m=", vim.lsp.buf.format, { desc = "Format Buffer" })
vim.keymap.set({ "n", "x" }, "<leader>m=", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "Format Buffer" })
-- vim.keymap.set({ "n", "x" }, "<leader>ma", vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set({ "n", "x" }, "<leader>ma", function()
  require("tiny-code-action").code_action {}
end, { desc = "Code Action" })
vim.keymap.set({ "n", "x" }, "<leader>mh", vim.lsp.buf.hover, { desc = "Hover Help" })
vim.keymap.set({ "n", "x" }, "<leader>mr", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set({ "n", "x" }, "<leader>mgd", vim.lsp.buf.definition, { desc = "Goto Definition" })
vim.keymap.set({ "n", "x" }, "<leader>mgi", vim.lsp.buf.implementation, { desc = "Goto Implementation" })
vim.keymap.set({ "n", "x" }, "<leader>mgr", vim.lsp.buf.references, { desc = "Find References" })
vim.keymap.set({ "n", "x" }, "<leader>mgs", vim.lsp.buf.document_symbol, { desc = "Find Symbols" })
vim.keymap.set({ "n", "x" }, "<leader>mgt", vim.lsp.buf.type_definition, { desc = "Goto Type-Definition" })
-- these follow vim lsp conventions instead
vim.keymap.set({ "n", "x" }, "grk", function()
  vim.lsp.buf.hover()
end, { desc = "vim.lsp.buf.hover()" })
vim.keymap.set({ "n", "x" }, "grd", function()
  vim.lsp.buf.definition()
end, { desc = "vim.lsp.buf.definition()" })

-- comments
vim.keymap.set("n", "<leader>cl", "gcc", { desc = "Toggle Comment Lines", remap = true })
vim.keymap.set("v", "<leader>cl", "gc", { desc = "Toggle Comment Lines", remap = true })

-- git
-- for convenience, spacemacs use magit instead
vim.keymap.set({ "n" }, "<leader>gacm", function()
  local msg = vim.fn.input "Commit message: "
  if msg and msg ~= "" then
    os.exec(string.format("git add --all && git commit -m %q", msg))
  else
    print "Commit aborted: No commit message provided."
  end
end, { desc = "git add commit" })
vim.keymap.set({ "n" }, "<leader>gacp", function()
  local msg = vim.fn.input "Commit message (push): "
  if msg and msg ~= "" then
    os.exec(string.format("git add --all && git commit -m %q && git push", msg))
  else
    print "Commit aborted: No commit message provided."
  end
end, { desc = "git add commit push" })
