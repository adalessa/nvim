local ok, lualine = pcall(require, "lualine")
if not ok then
	return
end

local function sail_status()
    return [[testing]]
end

lualine.setup({
	options = {
		theme = "tokyonight",
		icons_enabled = true,
		globalstatus = true,
	},
	extensions = { "quickfix", "fugitive" },
	sections = {
		lualine_a = { { "mode", upper = true } },
		lualine_b = { { "branch", icon = "" }, { "db_ui#statusline" }, "diff" },
		lualine_c = { { "filename", file_status = true, path = 1 } },
		lualine_x = { "diagnostics", sail_status },
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
