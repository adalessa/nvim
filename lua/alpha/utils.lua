local M = {}

M.save_and_exec = function()
  vim.api.nvim_command "silent w"
  vim.api.nvim_command "so"

  local current_file_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
  vim.notify(string.format("File %s Sourced", current_file_name), vim.log.levels.INFO, { title = "Alpha Developer" })
end

return M
