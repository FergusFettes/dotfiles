return {
  {
    "neovim/nvim-lspconfig",
    -- @class PluginLspOpts
    opts = {
      -- @type lspconfig.options
      servers = {
        pyright = { autostart = false },
        pylsp = {
          plugins = {
            pycodestyle = {
              ignore = { "W391", "W503", "E731", "E402" },
              maxLineLength = 120,
            },
            flake8 = {
              ignore = { "W503", "E731" },
              maxLineLength = 120,
            },
          },
        },
      },
    },
  },
}
