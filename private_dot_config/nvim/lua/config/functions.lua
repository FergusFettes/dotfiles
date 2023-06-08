-- local M = {}
--
-- function M.TmuxMove(direction)
-- 	local wnr = vim.fn.winnr()
-- 	-- If the winnr is still the same after we moved, it is the last pane
-- 	if vim.fn.exists("*wincmd") then
-- 		vim.fn.wincmd(direction)
-- 		if vim.fn.winnr() == wnr then
-- 			vim.fn.system("tmux select-pane -" .. vim.fn.substitute(direction, "phjkl", "lLDUR", "g"))
-- 		end
-- 	else
-- 		vim.cmd('echomsg "wincmd doesn\'t exist. You need to load it to use tmux_move"')
--   end
-- end
--
-- return M

vim.api.nvim_create_user_command(
    'TmuxMoveH',
    function(opts)
      local wnr = vim.fn.winnr()
    	vim.api.nvim_command('wincmd h')
      -- If the winnr is still the same after we moved, it is the last pane
      if vim.fn.winnr() == wnr then
      -- couldn't get this working, hence four functions 🤦
			-- vim.fn.system("tmux select-pane -" .. vim.fn.substitute(direction, "phjkl", "lLDUR", "g"))
        vim.fn.system("tmux select-pane -L")
      end
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'TmuxMoveJ',
    function(opts)
      local wnr = vim.fn.winnr()
    	vim.api.nvim_command('wincmd j')
      -- If the winnr is still the same after we moved, it is the last pane
      if vim.fn.winnr() == wnr then
        vim.fn.system("tmux select-pane -D")
      end
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'TmuxMoveK',
    function(opts)
      local wnr = vim.fn.winnr()
    	vim.api.nvim_command('wincmd k')
      -- If the winnr is still the same after we moved, it is the last pane
      if vim.fn.winnr() == wnr then
        vim.fn.system("tmux select-pane -U")
      end
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'TmuxMoveL',
    function(opts)
      local wnr = vim.fn.winnr()
    	vim.api.nvim_command('wincmd l')
      -- If the winnr is still the same after we moved, it is the last pane
      if vim.fn.winnr() == wnr then
        vim.fn.system("tmux select-pane -R")
      end
    end,
    { nargs = 0 }
)
