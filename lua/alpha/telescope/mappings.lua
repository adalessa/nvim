local map_tele = function(key, f, opts)
  local default = {
    mode = "n",
    options = {},
    buffer = nil,
    desc = nil,
  }
  opts = opts or {}
  opts = vim.tbl_deep_extend("force", default, opts or {})

  local rhs = function()
    R("alpha.telescope")[f](opts.options)
  end

  local map_options = {
    remap = false,
    silent = true,
  }
  if opts.buffer then
    map_options.buffer = opts.buffer
  end
  if opts.desc then
    map_options.desc = "Telescope: " .. opts.desc
  end

  vim.keymap.set(opts.mode, key, rhs, map_options)
end

-- not shure what this line does
vim.api.nvim_set_keymap(
  "c",
  "<c-r><c-r>",
  "<Plug>(TelescopeFuzzyCommandSearch)",
  { noremap = false, nowait = true, desc = "In comand look for previous commands" }
)

map_tele("<leader>pp", "project_files", { desc = "Open Project files" })
map_tele("<leader>gc", "branches", { desc = "Git Branches selector" })
map_tele("<leader>pw", "grep_word", { desc = "Grep word under cursor" })
map_tele("<leader>ps", "grep_string", { desc = "Grep provided input string" })
map_tele("<leader>rc", "search_config", { desc = "Search Files in .dotfiles directory" })
map_tele("<leader>rn", "find_nvim_config", { desc = "Search Files in nvim config directory" })
map_tele("<leader>rp", "find_nvim_plugin", { desc = "Search Neovim plugins" })
map_tele("<leader>rs", "scratchs", { desc = "Search Neovim Scratchs files" })
map_tele("<leader>ph", "help_tags", { desc = "Neovim Help" })
map_tele("<leader>pe", "buffers", { desc = "Open buffers" })
map_tele("<leader>pr", "treesitter", { desc = "Treesitter buffer elements" })
map_tele("<leader>bb", "file_browser_relative", { desc = "Current directory" })
map_tele("<leader>bp", "file_browser", { desc = "Project directory" })
map_tele("<leader>gs", "git_status", { desc = "Git status" })
map_tele("<leader>ve", "diagnostics", { desc = "Diagnostic of the buffer" })
map_tele("<leader>po", "api_specs", { desc = "Openapi directory" })
map_tele("<leader>pm", "gateway", { desc = "Graphql mutations and queries" })

return map_tele
