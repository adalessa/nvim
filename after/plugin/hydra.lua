local ok, hydra = pcall(require, "hydra")
if not ok then
    return
end

-- Windows management, move and resize
hydra({
    name = "windows",
    mode = "n",
    body = "<C-w>",
    heads = {
        { '<C-l>', '<C-w>l' },
        { '<C-h>', '<C-w>h' },
        { '<C-j>', '<C-w>j' },
        { '<C-k>', '<C-w>k' },
        { 'L', '<C-w>2>' },
        { 'H', '<C-w>2<' },
        { 'J', '<C-w>2-' },
        { 'K', '<C-w>2+' },
        { '=', '<C-w>=' },
    },
})
