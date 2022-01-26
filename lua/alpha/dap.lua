local dap = require('dap')
local api = vim.api

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { os.getenv('HOME') .. '/repos/vscode-php-debug/out/phpDebug.js' }
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9003,
    pathMappings = {
        ['/var/www/html'] = vim.fn.getcwd(),
        ['/app'] = vim.fn.getcwd(),
    }
  }
}


-- Events Listeners
dap.listeners.before['event_terminated']['alpha'] = function(session, body)
    print('Session terminated', vim.inspect(session), vim.inspect(body))
end


local function with_win(win, fn, ...)
  local cur_win = api.nvim_get_current_win()
  api.nvim_set_current_win(win)
  local ok, err = pcall(fn, ...)
  api.nvim_set_current_win(cur_win)
  assert(ok, err)
end


local function jump_to_location(bufnr, line, column)
  -- vscode-go sends columns with 0
  -- That would cause a "Column value outside range" error calling nvim_win_set_cursor
  -- nvim-dap says "columnsStartAt1 = true" on initialize :/
  if column == 0 then
    column = 1
  end
  for _, tab in pairs(api.nvim_list_tabpages()) do
      for _, win in pairs(api.nvim_tabpage_list_wins(tab)) do
        if api.nvim_win_get_buf(win) == bufnr then
          api.nvim_win_set_cursor(win, { line, column - 1 })
          api.nvim_set_current_tabpage(tab)
          api.nvim_set_current_win(win)
          return
        end
      end
    end
  -- TODO review
  -- Buffer isn't active in any window; use the first window that is not special
  -- (Don't want to move to code in the REPL...)
  for _, win in pairs(api.nvim_tabpage_list_wins(0)) do
    local winbuf = api.nvim_win_get_buf(win)
    if api.nvim_buf_get_option(winbuf, 'buftype') == '' then
      local bufchanged, _ = pcall(api.nvim_win_set_buf, win, bufnr)
      if bufchanged then
        api.nvim_win_set_cursor(win, { line, column - 1 })
        with_win(win, api.nvim_command, 'normal zv')
        return
      end
    end
  end
end


dap.listeners.after['event_stopped']['alpha'] = function(session, body)
    P(body.reason)
    if body.reason ~= 'breakpoint' then
        return
    end
    local path = session.current_frame.source.path
    local line = session.current_frame.line
    local column = session.current_frame.column

    local bufnr = vim.uri_to_bufnr(vim.uri_from_fname(path))
    vim.fn.bufload(bufnr)
    jump_to_location(bufnr, line, column)
end

vim.api.nvim_set_keymap('n', '<leader>dbp', ':lua require\'dap\'.toggle_breakpoint()<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>dd', ':lua require\'dap\'.continue()<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>dl', ':lua require\'dap\'.step_into()<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>dj', ':lua require\'dap\'.step_over()<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>dk', ':lua require\'dap\'.step_out()<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>dt', ':lua require\'dap\'.repl.toggle()<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ds', ':lua require\'alpha.dap-fn\'.scopes()<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>dbl', ':lua require\'dap\'.list_breakpoints()<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>dbc', ':lua require\'dap\'.clear_breakpoints()<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>dc', ':lua require\'dap\'.run_to_cursor()<cr>', {noremap = true})
