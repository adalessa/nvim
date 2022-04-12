TelescopeMapArgs = TelescopeMapArgs or {}

local map_tele = function(key, f, options, buffer)
	local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

	TelescopeMapArgs[map_key] = options or {}

	local mode = "n"
	local rhs = string.format("<cmd>lua R('alpha.telescope')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

	local map_options = {
		noremap = true,
		silent = true,
	}

	if not buffer then
		vim.api.nvim_set_keymap(mode, key, rhs, map_options)
	else
		vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
	end
end

-- not shure what this line does
vim.api.nvim_set_keymap("c", "<c-r><c-r>", "<Plug>(TelescopeFuzzyCommandSearch)", { noremap = false, nowait = true })

map_tele("<leader>pp", "project_files")
map_tele("<leader>gc", "branches")
map_tele("<leader>gt", "worktree")
map_tele("<leader>gn", "worktree_create")
map_tele("<leader>pw", "grep_word")
map_tele("<leader>ps", "grep_string")
map_tele("<leader>pf", "projectionist")
map_tele("<leader>rc", "search_config")
map_tele("<leader>ph", "help_tags")
map_tele("<leader>pe", "buffers")
map_tele("<leader>pr", "treesitter")
map_tele("<leader>bb", "file_browser_relative")
map_tele("<leader>bp", "file_browser")
map_tele("<leader>gs", "git_status")
map_tele("<leader>ve", "diagnostics")
map_tele("<leader>fp", "my_plugins")
map_tele("<leader>rr", "refactor")

map_tele("<leader>pa", "laravel")

return map_tele
