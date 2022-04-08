local ok, gitsigns = pcall(require, "gitsigns")
if not ok then
  return
end

gitsigns.setup({
    on_attach = function (bufnr)
        vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, {buffer = bufnr} )
        vim.keymap.set('n', '<leader>hu', gitsigns.undo_stage_hunk, {buffer = bufnr} )
        vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, {buffer = bufnr} )
        vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, {buffer = bufnr} )
        vim.keymap.set('n', '<leader>hj', gitsigns.next_hunk, {buffer = bufnr} )
        vim.keymap.set('n', '<leader>hk', gitsigns.prev_hunk, {buffer = bufnr} )
    end,
    max_file_length = 10000,
})
