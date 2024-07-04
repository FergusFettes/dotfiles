
vim.g.markdown_fenced_languages = { 'html', 'python', 'bash=sh', 'R=r' }
vim.opt.termguicolors = true

-- more opinionated
vim.opt.number = true -- show linenumbers
vim.opt.timeoutlen = 400 -- until which-key pops up
vim.opt.updatetime = 250 -- for autocommands and hovers
vim.opt.mouse= 'a' -- enable mouse
vim.opt.mousefocus = true
vim.opt.clipboard:append 'unnamedplus' -- use system clipboard

-- -- set auto read and make sure it triggers
-- -- oneliner: :set autoread | au CursorHold * checktime | call feedkeys("lh")
-- -- alias va='nvim -c "set autoread | au CursorHold * checktime | call feedkeys(\"lh\")"'
-- vim.opt.autoread = true
-- vim.cmd [[
--   augroup autoread
--     autocmd!
--     autocmd CursorHold * checktime | call feedkeys("lh")
--   augroup END
-- ]]

-- autocommand for formatting json files on opening
-- vimscript: autocmd FileType json silent execute '!jq . % > /tmp/vimjson' | read !cat /tmp/vimjson | 0d_
local jq_format = function()
  local json_file_path = vim.api.nvim_buf_get_name(0)
  local formatted_json = vim.fn.system('jq . ' .. json_file_path)

  if vim.v.shell_error == 0 then
    local lines = vim.split(formatted_json, "\n")
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  else
    vim.api.nvim_err_writeln('Failed to format JSON with jq.')
  end
end

vim.api.nvim_create_augroup('JsonFormat', {clear = true})
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = {"*.json", "*.JSON"},
  group = 'JsonFormat',
  callback = jq_format,
})

-- use spaces as tabs
local tabsize = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = tabsize
vim.opt.tabstop = tabsize

-- space as leader
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- smarter search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- colortheme tweaks
vim.g.nord_borders = true

-- indent
vim.opt.smartindent = true
vim.opt.breakindent = true

-- consisten number column
vim.opt.signcolumn = "yes:1"

-- how to show a autocomplete menu
vim.opt.completeopt = 'menuone,noinsert'

-- add folds with treesitter grammar
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- but open all by default
vim.opt.foldlevel = 99

-- global statusline
vim.opt.laststatus = 3

-- split right and below by default
vim.opt.splitright = true
vim.opt.splitbelow = true

--tabline
vim.opt.showtabline = 1

--windowline
vim.opt.winbar = '%t'

--don't continue comments automagically
vim.opt.formatoptions:remove({'c', 'r', 'o'})

-- turn off swapfiles!
vim.opt.swapfile = false

-- hide cmdline when not used
vim.opt.cmdheight = 0
vim.opt.conceallevel = 0


-- plugins
-- slime, general
vim.b.slime_cell_delimiter = "#%%"

-- -- slime, tmux
-- vim.g.slime_target = 'tmux'
-- vim.g.slime_bracketed_paste = 1
-- vim.g.slime_default_config = { socket_name = "default", target_pane = ".2" }

-- slime, neovvim terminal
vim.g.slime_target = "neovim"
-- vim.g.slime_python_ipython = 1

-- git blame, lualine
vim.g.gitblame_display_virtual_text = 0
