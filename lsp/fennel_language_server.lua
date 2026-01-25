return {
  -- https://miguelcrespo.co/posts/configuring-neovim-with-fennel/
  settings = {
    fennel = {
      workspace = {
        -- If you are using hotpot.nvim or aniseed,
        -- make the server aware of neovim runtime files.
        library = vim.api.nvim_list_runtime_paths(),
        checkThirdParty = false, -- THIS IS THE IMPORTANT LINE TO ADD
      },
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}
