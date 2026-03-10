local opts = { buffer = true, silent = true }

local function run_current_sql_block()
  local line_count = vim.api.nvim_buf_line_count(0)
  local cursor_line = vim.api.nvim_win_get_cursor(0)[1]

  local function is_blank(line_nr)
    local text = vim.fn.getline(line_nr)
    return text:match("^%s*$") ~= nil
  end

  if is_blank(cursor_line) then
    vim.cmd("%DB")
    return
  end

  local start_line = cursor_line
  while start_line > 1 and not is_blank(start_line - 1) do
    start_line = start_line - 1
  end

  local end_line = cursor_line
  while end_line < line_count and not is_blank(end_line + 1) do
    end_line = end_line + 1
  end

  vim.cmd(start_line .. "," .. end_line .. "DB")
end

vim.keymap.set("n", "<space><cr>", run_current_sql_block, opts)
vim.keymap.set("v", "<space><cr>", ":'<,'>DB<cr>", opts)
vim.keymap.set("n", "<space><space>", run_current_sql_block, opts)
