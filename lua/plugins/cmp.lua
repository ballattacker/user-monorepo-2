local M = {
  { import = "nvchad.blink.lazyspec" },

  {
    -- NOTE: need to download prebuilt binary manually because using `zig cc` leads to
    -- `cc -dumpmachine` outputing `x86_64-unknown-linux-musl` which is wrong
    -- https://github.com/saghen/blink.cmp/issues/160#issuecomment-2630207543
    "saghen/blink.cmp",
    dependencies = {
      "xzbdmw/colorful-menu.nvim",
      "fang2hou/blink-copilot",
      {
        "milanglacier/minuet-ai.nvim",
        opts = {
          -- provider = "openai_compatible",
          -- provider_options = {
          --   openai_compatible = {
          --     model = "arcee-ai/trinity-large-preview:free",
          --   },
          -- },

          provider = "openai_fim_compatible",
          n_completions = 1, -- recommend for local model for resource saving
          -- I recommend beginning with a small context window size and incrementally
          -- expanding it, depending on your local computing power. A context window
          -- of 512, serves as an good starting point to estimate your computing
          -- power. Once you have a reliable estimate of your local computing power,
          -- you should adjust the context window to a larger value.
          context_window = 512,
          provider_options = {
            openai_fim_compatible = {
              -- For Windows users, TERM may not be present in environment variables.
              -- Consider using APPDATA instead.
              api_key = "TERM",
              name = "Llama.cpp",
              end_point = "http://localhost:8012/v1/completions",
              -- The model is set by the llama-cpp server and cannot be altered
              -- post-launch.
              model = "PLACEHOLDER",
              optional = {
                max_tokens = 56,
                top_p = 0.9,
              },
              -- Llama.cpp does not support the `suffix` option in FIM completion.
              -- Therefore, we must disable it and manually populate the special
              -- tokens required for FIM completion.
              template = {
                prompt = function(context_before_cursor, context_after_cursor, _)
                  return "<|fim_prefix|>"
                    .. context_before_cursor
                    .. "<|fim_suffix|>"
                    .. context_after_cursor
                    .. "<|fim_middle|>"
                end,
                suffix = false,
              },
            },
          },
        },
      },
    },
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
        -- Recommended to avoid unnecessary AI request
        trigger = { prefetch_on_insert = false },
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
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "copilot",
          "minuet",
        },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            async = true,
          },
          minuet = {
            name = "minuet",
            module = "minuet.blink",
            async = true,
          },
        },
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
