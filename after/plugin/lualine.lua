local ok, lualine = pcall(require, "lualine")
if not ok then
	return
end

lualine.setup({
	options = {
		theme = vim.g.alpha_lualine_color,
		icons_enabled = true,
		globalstatus = true,
	},
	extensions = { "quickfix", "fugitive" },
	sections = {
		lualine_a = { { "mode", upper = true } },
		lualine_b = { { "branch", icon = "" }, { "db_ui#statusline" }, "diff" },
		lualine_c = { { "filename", file_status = true, path = 1 } },
		lualine_x = { "diagnostics" },
		lualine_y = { "encoding", "fileformat" },
		lualine_z = { "filetype" },
	},
	winbar = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	inactive_winbar = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
})
