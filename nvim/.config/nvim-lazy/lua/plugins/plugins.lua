return {
  {
    "neovim/nvim-lspconfig",
    -- @class PluginLspOpts
    opts = {
      -- @type lspconfig.options
      format_notify = true,
      servers = {
        pyright = { autostart = false },
        pylsp = {
          -- configurationSources = {"pycodestyle", "flake8"},
          autostart = true,
          plugins = {
            pycodestyle = {
              enabled = false,
              ignore = { "W391", "W503", "E731", "E402" },
              maxLineLength = 120,
            },
            flake8 = {
              enabled = false,
              ignore = { "W503", "E731" },
              maxLineLength = 120,
            },
            autopep8 = {
              enabled = false,
            },
            pylint = {
              enabled = false,
            },
            pyflakess = {
              enabled = false,
            },
          },
        },
      },
    },
  },
}
