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
		{ "l", "<C-w>l" },
		{ "h", "<C-w>h" },
		{ "j", "<C-w>j" },
		{ "k", "<C-w>k" },
		{ "q", "<C-w>q" },
		{ "o", "<C-w>o" },
		{ "L", "<C-w>2>" },
		{ "H", "<C-w>2<" },
		{ "J", "<C-w>2-" },
		{ "K", "<C-w>2+" },
		-- { "<C-l>", "<C-w>L" },
		-- { "<C-h>", "<C-w>H" },
		-- { "<C-j>", "<C-w>J" },
		-- { "<C-k>", "<C-w>K" },
		{ "=", "<C-w>=" },
	},
})

-- want a way to run make commands
-- Make commands runs good but the output is not good
-- like up I like that is done and good
-- hydra({
-- 	name = "make",
-- 	mode = "n",
-- 	body = "<C-m>",
--     config = {
--         color = "blue",
--     },
-- 	heads = {
-- 		{ "t", function() vim.cmd("vsplit term://make test") end },
--         { "v", function()
--             vim.cmd('vert new')
--             vim.fn.termopen("make vars")
--             vim.cmd('startinsert')
--         end, {exit = true} },
-- 	},
-- })
