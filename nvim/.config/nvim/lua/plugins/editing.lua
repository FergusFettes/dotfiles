return {
  { 'tpope/vim-repeat' },
  { 'tpope/vim-surround' },
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', config = function()
    require("ibl").setup {
      scope = { enabled = true },
    }
  end
  },
  -- commenting with e.g. `gcc` or `gcip`
  -- respects TS, so it works in quarto documents
  { 'numToStr/Comment.nvim', config = function()
    require('Comment').setup {}
  end
  },
  { 'dhruvasagar/vim-table-mode' },
}
