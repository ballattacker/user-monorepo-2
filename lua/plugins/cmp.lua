local M = {
  { import = "nvchad.blink.lazyspec" },

  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "none",

        ["<C-l>"] = { "show", "accept" },
        -- INFO: https://github.com/saghen/blink.cmp/issues/2119
        -- ["<C-m>"] = { "accept_and_enter" },
        -- INFO: override nvchad.blink.lazyspec
        ["<CR>"] = { "fallback" },
        ["<C-u>"] = { "hide", "fallback" },
        ["<C-h>"] = {
          function(cmp)
            cmp.hide()
            vim.api.nvim_input "<C-w>"
            return true
          end,
        },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-n>"] = { "select_next", "fallback_to_mappings" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },

        ["<C-d>"] = { "scroll_documentation_up", "scroll_signature_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "scroll_signature_down", "fallback" },

        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },

        ["<C-i>"] = { "hide_documentation", "hide_signature", "hide", "fallback_to_mappings" },
        ["<C-o>"] = { "show_documentation", "show_signature", "show", "fallback_to_mappings" },
      },
      completion = {
        list = { selection = { preselect = true, auto_insert = false } },
        documentation = { auto_show = true },
        ghost_text = { enabled = true },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      -- signature = { enabled = true },
      cmdline = {
        completion = {
          menu = { auto_show = true },
          list = { selection = { preselect = true, auto_insert = false } },
        },
        keymap = { preset = "inherit" },
      },
    },
    opts_extend = { "sources.default" },
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            ["<C-d>"] = "preview_scrolling_down",
            ["<C-u>"] = "preview_scrolling_up",
            ["<C-h>"] = function()
              vim.api.nvim_input "<C-w>"
            end,
            ["<C-l>"] = "select_default",
            ["<C-m>"] = "select_default",
          },
        },
      },
    },
  },
}

return M
