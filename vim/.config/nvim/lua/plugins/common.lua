return {
  -- common dependencies
  { 'nvim-lua/plenary.nvim' },
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
            accept = "<C-k>",
            accept_word = '<C-j>',
            accept_line = "<C-l>",
          },
        },
        filetypes = {
          -- yaml = true,
          markdown = true,
        },
      })
    end,
  },
  { 'francoiscabrol/ranger.vim' },
  { 'rbgrouleff/bclose.vim' },
  { 'Asheq/close-buffers.vim' },
  { 'tpope/vim-dadbod' },
}
