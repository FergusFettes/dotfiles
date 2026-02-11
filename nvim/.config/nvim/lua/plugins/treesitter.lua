return {
  { 'nvim-treesitter/nvim-treesitter', branch = 'master', build = ':TSUpdate', config = function()
    require 'nvim-treesitter.configs'.setup {
      ensure_installed = { 'python', 'lua', 'sql', 'markdown', 'markdown_inline', 'yaml', 'vim', 'vimdoc', 'bash' },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
    }
  end },
}
