return {
  -- common dependencies
  { 'nvim-lua/plenary.nvim' },
  {
    "ipod825/libp.nvim",
    config = function()
      require("libp").setup()
    end,
  },
  {
    "ipod825/ranger.nvim",
    config = function()
      require("ranger").setup()
    end,
  },
  -- copilot plug with entire config for easy editing
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = "<M-;>",
            accept_word = "<M-k>",
            accept_line = "<M-l>",
          },
        },
        filetypes = {
          -- yaml = true,
          -- markdown = true,
        },
      })
    end,
  },
}
