local ok, lsp_lines = pcall(require, "lsp_lines")
if not ok then
	return
end

vim.diagnostic.config({
  virtual_text = false,
})

lsp_lines.setup()
