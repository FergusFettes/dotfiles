return {
  --  {
  --   'Exafunction/codeium.vim',
  --   config = function ()
  --     -- Change '<C-g>' here to any keycode you like.
  --     vim.keymap.set('i', '<C-j>', function () return vim.fn['codeium#Accept']() end, { expr = true })
  --     vim.keymap.set('i', '<A-]>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
  --     vim.keymap.set('i', '<A-[>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
  --   end
  -- }, -- common dependencies
  { 'nvim-lua/plenary.nvim' },
  { 'mbbill/undotree' },
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
