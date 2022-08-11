local ok, lsp_lines = pcall(require, "lsp_lines")
if not ok then
	return
end

vim.diagnostic.config({
  virtual_text = false,
})

vim.diagnostic.config({ virtual_lines = { only_current_line = true } })

lsp_lines.setup()

vim.keymap.set(
  "",
  "<Leader>l",
  require("lsp_lines").toggle,
  { desc = "Toggle lsp_lines" }
)
