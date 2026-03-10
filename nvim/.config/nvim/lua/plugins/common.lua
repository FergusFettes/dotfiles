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
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({
  --       suggestion = {
  --         auto_trigger = true,
  --         keymap = {
  --           accept = "<C-k>",
  --           accept_word = '<C-j>',
  --           accept_line = "<C-l>",
  --         },
  --       },
  --       filetypes = {
  --         -- yaml = true,
  --         markdown = true,
  --       },
  --     })
  --   end,
  -- },
  { 'francoiscabrol/ranger.vim' },
  { 'rbgrouleff/bclose.vim' },
  { 'Asheq/close-buffers.vim' },
  { 'echasnovski/mini.icons' },
  { 'tpope/vim-dadbod' },
  {
    'preservim/vim-markdown',
    ft = { 'markdown' },
    init = function()
      vim.g.vim_markdown_conceal = 2
      vim.g.vim_markdown_strikethrough = 1
    end,
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = { 'tpope/vim-dadbod' },
    cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_save_location = vim.fn.expand('~/worldtree/work/command-center/.dadbod-ui')
      vim.fn.mkdir(vim.g.db_ui_save_location, 'p')
    end,
  },
  {
    'kristijanhusak/vim-dadbod-completion',
    dependencies = { 'tpope/vim-dadbod' },
    ft = { 'sql', 'mysql', 'plsql' },
  },
}
