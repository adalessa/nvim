vim.keymap.set("n", "<leader>vn", vim.diagnostic.goto_next, {})
vim.keymap.set("n", "<leader>vp", vim.diagnostic.goto_prev, {})

vim.diagnostic.config({
	virtual_text = false,
})

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
