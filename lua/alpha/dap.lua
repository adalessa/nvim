local dap = require('dap')


-- TODO replace pad with env variables
dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { '/home/alpha/repos/vscode-php-debug/out/phpDebug.js' }
}

-- TODO make 'mapping' configurateble
dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9003,
    pathMappings = {
        ['/var/www/html'] = vim.fn.getcwd()
    }
  }
}

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
