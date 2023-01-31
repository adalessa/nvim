TelescopeMapArgs = TelescopeMapArgs or {}

local map_tele = function(key, f, options, buffer, mode)
  mode = mode or "n"

  local rhs = function()
    R("alpha.telescope")[f](options or {})
  end

  local map_options = {
    remap = false,
    silent = true,
  }
  if buffer then
    map_options.buffer = buffer
  end

  vim.keymap.set(mode, key, rhs, map_options)
end

-- not shure what this line does
vim.api.nvim_set_keymap("c", "<c-r><c-r>", "<Plug>(TelescopeFuzzyCommandSearch)", { noremap = false, nowait = true })

map_tele("<leader>pp", "project_files")
map_tele("<leader>gc", "branches")
map_tele("<leader>pw", "grep_word")
map_tele("<leader>ps", "grep_string")
map_tele("<leader>pf", "projectionist")
map_tele("<leader>rc", "search_config")
map_tele("<leader>rn", "find_nvim_config")
map_tele("<leader>rp", "find_nvim_plugin")
map_tele("<leader>ph", "help_tags")
map_tele("<leader>pe", "buffers")
map_tele("<leader>pr", "treesitter")
map_tele("<leader>bb", "file_browser_relative")
map_tele("<leader>bp", "file_browser")
map_tele("<leader>gs", "git_status")
map_tele("<leader>ve", "diagnostics")
map_tele("<leader>fp", "my_plugins")
map_tele("<leader>po", "api_specs")
map_tele("<leader>pm", "gateway")

return map_tele
