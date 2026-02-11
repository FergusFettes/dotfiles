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
  { 'numToStr/Comment.nvim', config = function()
    require('Comment').setup {}
  end
  },
  -- d/c/x don't yank; use 'm' (move) to cut to clipboard (replaces vim-easyclip)
  { 'gbprod/cutlass.nvim', config = function()
    require('cutlass').setup { cut_key = 'm' }
  end },
  { 'dhruvasagar/vim-table-mode' },
}
