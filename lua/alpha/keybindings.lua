local map = vim.keymap.set

map("v", "<leader>p", '"_dp')

map("n", "bd", ":bd!<CR>")

-- lists navigation
map("n", "<leader>j", ":cnext<CR>zz")
map("n", "<leader>k", ":cprev<CR>zz")
map("n", "<leader>i", ":lnext<CR>zz")
map("n", "<leader>o", ":lprev<CR>zz")
map("n", "<leader>cc", ":cclose<CR>")

-- quick split
map("n", "<leader>wsv", ":vsp<CR>")

-- tabulation
map("v", "<", "<gv")
map("v", ">", ">gv")

-- symbols to add undo points
local symbols = { ",", ".", "!", "?", "$", ">", "<" }
for _, symbol in pairs(symbols) do
	map("i", symbol, symbol .. "<c-g>u")
end

-- search result focus
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- join lines focus
map("n", "J", "mzJ`z")

-- Terminal
map("t", "<Esc><Esc>", "<C-\\><C-n>")
map("t", "<C-w>h", "<C-\\><C-n><C-w>h")
map("t", "<C-w>j", "<C-\\><C-n><C-w>j")
map("t", "<C-w>k", "<C-\\><C-n><C-w>k")
map("t", "<C-w>l", "<C-\\><C-n><C-w>l")

-- quick env file edit
map("n", "<leader>ee", ":vsp .env<CR>")

-- quick save and exec
map("n", "<leader><leader>x", require("alpha.utils").save_and_exec)
