local wk = require("which-key")

P = function(x)
  print(vim.inspect(x))
  return (x)
end

RELOAD = function(...)
  return require 'plenary.reload'.reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end

-- turn off linenumber
vim.keymap.set("n", "<leader>nn", ":set nu!<cr>")

-- jk is escape
vim.keymap.set("i", "jk", "<esc>")

-- ranger
-- remove the default mapping for <leader>f. the new mapping is set below
vim.keymap.del("n", "<leader>f")

--move vertically by visual line
vim.keymap.set("n", "j",  "gj")
vim.keymap.set("n", "k",  "gk")

-- --move vertically by visual line
-- vim.keymap.set("n", "gm",  "m")

-- enter behaviour
vim.keymap.set("n", "<cr>", "o<Esc>")

-- save in insert mode
vim.keymap.set("i", "<C-s>", "<cmd>:w<cr><esc>")
vim.keymap.set("n", "<C-s>", "<cmd>:w<cr><esc>")

-- Move between windows using <ctrl> direction
vim.keymap.set("n", '<C-j>', '<C-W>j')
vim.keymap.set("n", '<C-k>', '<C-W>k')
vim.keymap.set("n", '<C-h>', '<C-W>h')
vim.keymap.set("n", '<C-l>', '<C-W>l')

-- Move between windows using <alt> direction
vim.keymap.set("n", "<A-j>", ":TmuxMoveJ<CR>", {silent = false})
vim.keymap.set("n", "<A-k>", ":TmuxMoveK<CR>", {silent = false})
vim.keymap.set("n", "<A-h>", ":TmuxMoveH<CR>", {silent = false})
vim.keymap.set("n", "<A-l>", ":TmuxMoveL<CR>", {silent = false})

-- keymaps for nvim magin
vim.keymap.set("v", "<leader>ec", "<Plug>nvim-magic-append-completion")

-- Add undo break-points
-- vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- Dadbod connections are managed by vim-dadbod-ui connections.json
local function refresh_dadbod_connections()
  local repo_dir = vim.fn.expand("~/worldtree/work/command-center")
  if vim.fn.isdirectory(repo_dir) == 0 then
    repo_dir = vim.fn.expand("~/worldtree/projects/db-command-center")
  end
  local script = repo_dir .. "/gen-connections"

  if vim.fn.filereadable(script) == 0 then
    vim.notify("gen-connections not found at " .. script, vim.log.levels.WARN)
    return
  end

  vim.notify("Refreshing dadbod connections...", vim.log.levels.INFO)
  local stderr = {}
  vim.fn.jobstart({ "uv", "run", "./gen-connections" }, {
    cwd = repo_dir,
    stderr_buffered = true,
    on_stderr = function(_, data)
      if not data then
        return
      end
      for _, line in ipairs(data) do
        if line and line ~= "" then
          table.insert(stderr, line)
        end
      end
    end,
    on_exit = function(_, code)
      if code == 0 then
        vim.notify("Dadbod connections refreshed. Reopen DBUI to reload list.", vim.log.levels.INFO)
      else
        local detail = stderr[#stderr] and (" " .. stderr[#stderr]) or ""
        vim.notify("Dadbod connection refresh failed." .. detail, vim.log.levels.ERROR)
      end
    end,
  })
end

local function show_dadbod_connection_url(opts)
  local name = opts.args
  if name == "" then
    local line = vim.api.nvim_get_current_line()
    name = line:match("^%s*[^A-Za-z0-9]*([-A-Za-z0-9_.:]+)") or ""
  end

  if name == "" then
    vim.notify("No connection name found. Use :DBShowConnectionUrl <name>.", vim.log.levels.WARN)
    return
  end

  local save_dir = vim.g.db_ui_save_location or vim.fn.expand("~/.local/share/db_ui")
  local paths = {
    save_dir .. "/connections.json",
    vim.fn.expand("~/.local/share/db_ui/connections.json"),
  }

  local url = nil
  for _, path in ipairs(paths) do
    if vim.fn.filereadable(path) == 1 then
      local ok_read, lines = pcall(vim.fn.readfile, path)
      if ok_read and #lines > 0 then
        local ok_decode, decoded = pcall(vim.json.decode, table.concat(lines, "\n"))
        if ok_decode and type(decoded) == "table" then
          for _, entry in ipairs(decoded) do
            if type(entry) == "table" and entry.name == name and entry.url then
              url = entry.url
              break
            end
          end
        end
      end
    end
    if url then
      break
    end
  end

  if not url and type(vim.g.dbs) == "table" then
    url = vim.g.dbs[name]
  end

  if not url then
    vim.notify("Connection not found: " .. name, vim.log.levels.WARN)
    return
  end

  vim.fn.setreg("+", url)
  vim.notify(name .. " URL copied to clipboard.", vim.log.levels.INFO)
end

vim.api.nvim_create_user_command("DBRefreshConnections", refresh_dadbod_connections, {})
vim.api.nvim_create_user_command("DBShowConnectionUrl", show_dadbod_connection_url, { nargs = "?" })
vim.keymap.set("n", "<leader>d", ":DBUI<CR>")

-- setup a toggleterm for ipython
vim.keymap.set("n", "<leader>ip", ":ToggleTerm direction=float size=20<CR>poetry run ipython<CR>")

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'yu', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<M-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<M-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<M-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<M-l>', [[<Cmd>wincmd l<CR>]], opts)
end

function _G.set_toggleterminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('v', '<CR>', ':ToggleTermSendVisualLines<CR>')
end

-- vmap('<cr>', '<Plug>SlimeRegionSend')

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_toggleterminal_keymaps()')

local nmap = function(key, effect)
  vim.keymap.set('n', key, effect, { silent = true, noremap = true })
end

local vmap = function(key, effect)
  vim.keymap.set('v', key, effect, { silent = true, noremap = true })
end

local imap = function(key, effect)
  vim.keymap.set('i', key, effect, { silent = true, noremap = true })
end

local function switchTheme()
  if vim.o.background == 'light' then
    vim.o.background = 'dark'
    vim.cmd [[Catppuccin mocha]]
  else
    vim.o.background = 'light'
    vim.cmd [[Catppuccin latte]]
  end
end

nmap('Q', '<Nop>')

-- send code with ctrl+Enter
-- just like in e.g. RStudio
-- needs kitty (or other terminal) config:
-- map shift+enter send_text all \x1b[13;2u
-- map ctrl+enter send_text all \x1b[13;5u
nmap('<c-cr>', '<Plug>SlimeSendCell')
nmap('<s-cr>', '<Plug>SlimeSendCell')
imap('<c-cr>', '<esc><Plug>SlimeSendCell<cr>i')
imap('<s-cr>', '<esc><Plug>SlimeSendCell<cr>i')

-- send code with Enter and leader Enter
vmap('<cr>', '<Plug>SlimeRegionSend')
nmap('<leader><cr>', '<Plug>SlimeSendCell')

-- list hidden buffers
nmap('<leader>ls', ':ls!<cr>')
nmap('<leader>vh', ':execute "h " . expand("<cword>")<cr>')

-- source entire file
nmap('<leader>xx', ':w<cr>:source %<cr>')

-- keep selection after indent/dedent
vmap('>', '>gv')
vmap('<', '<gv')

-- remove search highlight on esc
nmap('<esc>', '<cmd>noh<cr>')

-- find files with telescope
nmap('<c-p>', "<cmd>Telescope find_files<cr>")

-- paste and without overwriting register
vmap("<leader>p", "\"_dP")

-- delete and without overwriting register
vmap("<leader>d", "\"_d")

nmap("<leader>6", ":%!base64 -w 0<cr>")
nmap("<leader>4", ":%!base64 -d<cr>")

-- center after search and jumps
nmap('n', "nzz")
nmap('<c-d>', '<c-d>zz')
nmap('<c-u>', '<c-u>zz')

-- terminal mode
-- get out ouf terminal insert mode with esc
vim.keymap.set('t', '<esc>', [[<c-\><c-n>]], { silent = true, noremap = true })
--move to other window
vim.keymap.set('t', '<c-j>', [[<c-\><c-n><c-w>w]], { silent = true, noremap = true })
vim.keymap.set('n', '<leader>j', [[<c-w>wi]], { silent = true, noremap = true })

-- open filetree
nmap('<c-b>', '<cmd>NvimTreeToggle<cr>')

-- move between splits and tabs
nmap('<c-h>', '<c-w>h')
nmap('<c-l>', '<c-w>l')
nmap('<c-j>', '<c-w>j')
nmap('<c-k>', '<c-w>k')
nmap('H', '<cmd>tabprevious<cr>')
nmap('L', '<cmd>tabnext<cr>')

local function open_plugin()
  local word = vim.fn.expand('<cWORD>')
  -- url = string.match(url, '".+"')
  local url = string.match(word, '%b""')
  if url ~= nil then
    url = string.gsub(url, '["\']', '')
  else
    url = string.match(word, "%b''")
    if url ~= nil then
      url = string.gsub(url, '["\']', '')
    end
  end
  url = 'https://github.com/' .. url
  local cmd = "!brave-browser " .. url
  vim.cmd(cmd)
end

vim.keymap.set('n', '<leader>vp', open_plugin)

--show kepbindings with whichkey
--add your own here if you want them to
--show up in the popup as well
wk.add({
  { "<leader>a", group = "AI Asisstant" },
  { "<leader>an", ":BFFilePrompt ", desc = "Prompt" },
  { "<leader>b", group = "buffer" },
  { "<leader>bb", ":Telescope buffers<cr>", desc = "buffers" },
  { "<leader>bd", ":Bdelete menu<cr>", desc = "delete buffer" },
  { "<leader>bx", ":bn<cr>", desc = "next buffer" },
  { "<leader>bz", ":bp<cr>", desc = "previous buffer" },
  { "<leader>c", group = "code" },
  { "<leader>ca", ":w !autopep8 -i %<cr> && :e %<cr>", desc = "autopep8" },
  { "<leader>cb", ":!./build.sh<cr>", desc = "build" },
  { "<leader>cc", ":SlimeConfig<cr>", desc = "slime config" },
  { "<leader>cf", ":w !black -<cr> && :e %<cr>", desc = "black" },
  { "<leader>ci", ":split term://ipython<cr>", desc = "new ipython terminal" },
  { "<leader>cj", ":split term://julia<cr>", desc = "new julia terminal" },
  { "<leader>cn", ":split term://$SHELL<cr>", desc = "new terminal" },
  { "<leader>cp", ":split term://python<cr>", desc = "new python terminal" },
  { "<leader>cr", ":split term://R<cr>", desc = "new R terminal" },
  { "<leader>cs", ":echo b:terminal_job_id<cr>", desc = "show terminal id" },
  { "<leader>cx", ":w !prettier --stdin-filepath --parser babel %<cr> && :e %<cr>", desc = "prettier" },
  { "<leader>f", group = "find (telescope)" },
  { "<leader>fM", "<cmd>Telescope man_pages<cr>", desc = "man pages" },
  { "<leader>fb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "fuzzy" },
  { "<leader>fc", "<cmd>Telescope git_commits<cr>", desc = "git commits" },
  { "<leader>fd", "<cmd>Telescope buffers<cr>", desc = "buffers" },
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "files" },
  { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "grep" },
  { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "help" },
  { "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "marks" },
  { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "keymaps" },
  { "<leader>fl", "<cmd>Telescope loclist<cr>", desc = "loclist" },
  { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "marks" },
  { "<leader>fp", "<cmd>Telescope project<cr>", desc = "project" },
  { "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "quickfix" },
  { "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "references" },
  { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "symbols" },
  { "<leader>g", group = "git" },
  { "<leader>gc", ":GitConflictRefresh<cr>", desc = "conflict" },
  { "<leader>gd", group = "diff" },
  { "<leader>gdc", ":DiffviewClose<cr>", desc = "close" },
  { "<leader>gdo", ":DiffviewOpen<cr>", desc = "open" },
  { "<leader>gg", ":Neogit<cr>", desc = "neogit" },
  { "<leader>gpl", ":Octo pr list<cr>", desc = "gh pr list" },
  { "<leader>gpr", ":Octo review start<cr>", desc = "gh pr review" },
  { "<leader>gs", ":Gitsigns<cr>", desc = "gitsigns" },
  { "<leader>gwc", ":lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", desc = "worktree create" },
  { "<leader>gws", ":lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", desc = "worktree switch" },
  { "<leader>l", group = "language/lsp" },
  { "<leader>lD", vim.lsp.buf.type_definition, desc = "type definition" },
  { "<leader>lR", vim.lsp.buf.rename, desc = "rename" },
  { "<leader>la", vim.lsp.buf.code_action, desc = "coda action" },
  { "<leader>ld", group = "diagnostics" },
  { "<leader>ldd", vim.diagnostic.disable, desc = "disable" },
  { "<leader>lde", vim.diagnostic.enable, desc = "enable" },
  { "<leader>le", vim.diagnostic.open_float, desc = "diagnostics" },
  { "<leader>lf", vim.lsp.buf.format, desc = "format" },
  { "<leader>lo", ":SymbolsOutline<cr>", desc = "outline" },
  { "<leader>lr", "<cmd>Telescope lsp_references<cr>", desc = "references" },
  { "<leader>q", group = "quarto" },
  { "<leader>qE", ":lua require'otter'.export(true)<cr>", desc = "export overwrite" },
  { "<leader>qe", ":lua require'otter'.export()<cr>", desc = "export" },
  { "<leader>qh", ":QuartoHelp ", desc = "help" },
  { "<leader>qp", ":lua require'quarto'.quartoPreview()<cr>", desc = "preview" },
  { "<leader>qq", ":lua require'quarto'.quartoClosePreview()<cr>", desc = "close" },
  { "<leader>r", group = "run/read/ranger" },
  { "<leader>re", ":Ranger<cr>", desc = "ranger" },
  { "<leader>rg", ":Goyo | set linebreak<cr>", desc = "goyo" },
  { "<leader>rh", ":Goyo 80% | set linebreak<cr>", desc = "goyo wide" },
  { "<leader>rpl", ":split <cr>:terminal poetry run pytest --lf -s %<cr>", desc = "pytestlf" },
  { "<leader>rpp", ":split <cr>:terminal python -m %<cr>", desc = "python" },
  { "<leader>rpt", ":split <cr>:terminal poetry run pytest %<cr>", desc = "pytest" },
  { "<leader>rr", ':lua require("otter").run()<cr>', desc = "run" },
  { "<leader>s", group = "spellcheck" },
  { "<leader>s/", "<cmd>setlocal spell!<cr>", desc = "spellcheck" },
  { "<leader>s?", "<cmd>Telescope spell_suggest<cr>", desc = "suggest" },
  { "<leader>sb", "zw", desc = "bad" },
  { "<leader>sg", "zg", desc = "good" },
  { "<leader>sn", "]s", desc = "next" },
  { "<leader>sp", "[s", desc = "previous" },
  { "<leader>sr", "zg", desc = "right" },
  { "<leader>ss", "<cmd>Telescope spell_suggest<cr>", desc = "spelling" },
  { "<leader>sw", "zw", desc = "wrong" },
  { "<leader>t", group = "treesitter" },
  { "<leader>th", ":TSNodeUnderCursor<cr>", desc = "hover" },
  { "<leader>v", group = "vim" },
  { "<leader>ve", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k<cr>", desc = "Settings" },
  { "<leader>vl", ":Lazy<cr>", desc = "Lazy" },
  { "<leader>vm", ":Mason<cr>", desc = "Mason" },
  { "<leader>vt", switchTheme, desc = "switch theme" },
}, { mode = "n" })

-- normal mode
wk.add({
  { "<c-LeftMouse>", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "go to definition" },
  { "<c-q>", "<cmd>q<cr>", desc = "close buffer" },
  { "<cm-i>", "o```{python}<cr>```<esc>O", desc = "r code chunk" },
  { "<esc>", "<cmd>noh<cr>", desc = "remove search highlight" },
  { "<m-I>", "o```{python}<cr>```<esc>O", desc = "r code chunk" },
  { "<m-i>", "o```{r}<cr>```<esc>O", desc = "r code chunk" },
  { "cO", "O#%%<cr>", desc = "new code chunk above" },
  { "co", "o#%%<cr>", desc = "new code chunk below" },
  { "gN", "Nzzzv", desc = "center search" },
  { "gf", ":e <cfile><CR>", desc = "edit file" },
  { "gl", "<c-]>", desc = "open help link" },
  { "gx", ":!xdg-open <c-r><c-a><cr>", desc = "open file" },
  { "n", "nzzzv", desc = "center search" },
}, { mode = "n" })

-- visual mode
wk.add({
  {
    mode = { "v" },
    { ".", ":norm .<cr>", desc = "repat last normal mode command" },
    { "<M-j>", ":m'>+<cr>`<my`>mzgv`yo`z", desc = "move line down" },
    { "<M-k>", ":m'<-2<cr>`>my`<mzgv`yo`z", desc = "move line up" },
    { "<cr>", "<Plug>SlimeRegionSend", desc = "run code region" },
    { "gx", '"ty:!xdg-open t<cr>', desc = "open file" },
    { "q", ":norm @q<cr>", desc = "repat q macro" },
  },
})

wk.add({
  { "<leader><leader>", "<Plug>SlimeRegionSend", desc = "run code region", mode = "v" },
  { "<leader>p", '"_dP', desc = "replace without overwriting reg", mode = "v" },
})

wk.add({
  {
    mode = { "i" },
    { "<cm-i>", "<esc>o```{python}<cr>```<esc>O", desc = "r code chunk" },
    { "<m-->", " <- ", desc = "assign" },
    { "<m-I>", "<esc>o```{python}<cr>```<esc>O", desc = "r code chunk" },
    { "<m-i>", "```{r}<cr>```<esc>O", desc = "r code chunk" },
    { "<m-m>", " |>", desc = "pipe" },
  },
})
