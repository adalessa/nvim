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
        { 'l', '<C-w>l' },
        { 'h', '<C-w>h' },
        { 'j', '<C-w>j' },
        { 'k', '<C-w>k' },
        { 'q', '<C-w>q' },
        { 'L', '<C-w>2>' },
        { 'H', '<C-w>2<' },
        { 'J', '<C-w>2-' },
        { 'K', '<C-w>2+' },
        { '<C-l>', '<C-w>L' },
        { '<C-h>', '<C-w>H' },
        { '<C-j>', '<C-w>J' },
        { '<C-k>', '<C-w>K' },
        { '=', '<C-w>=' },
    },
})
