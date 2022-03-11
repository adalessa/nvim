local ok, trouble = pcall(require, "trouble")

if not ok then
    return
end

trouble.setup {}

vim.keymap.set('n', '<leader>tt', ':TroubleToggle<cr>')
