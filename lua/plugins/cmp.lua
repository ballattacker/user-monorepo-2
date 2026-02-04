local M = {
  { import = "nvchad.blink.lazyspec" },

  {
    -- NOTE: need to download prebuilt binary manually because using `zig cc` leads to
    -- `cc -dumpmachine` outputing `x86_64-unknown-linux-musl` which is wrong
    -- https://github.com/saghen/blink.cmp/issues/160#issuecomment-2630207543
    "saghen/blink.cmp",
    dependencies = { "xzbdmw/colorful-menu.nvim" },
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "none",

        ["<C-l>"] = { "show", "accept" },
        -- TODO: https://github.com/saghen/blink.cmp/issues/2119
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
        menu = {
          draw = {
            -- We don't need label_description now because label and label_description are already
            -- combined together in label by colorful-menu.nvim.
            -- columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
            },
          },
        },
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
}

return M
