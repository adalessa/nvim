local ok, feline = pcall(require, "feline")
if not ok then
	return
end

local my_theme = {
	bg = "#131a24",
	bg1 = "#192330",
	black = "#131a24",
	skyblue = "#719cd6",
	cyan = "#63cdcf",
	fg = "#aeafb0",
	green = "#81b29a",
	magenta = "#9d79d6",
	orange = "#f4a261",
	red = "#c94f6d",
	white = "#dfdfe0",
	yellow = "#dbc074",
	oceanblue = "#39506d",
}

feline.setup()
feline.use_theme(my_theme)


-- Winbar
local winbar_fileinfo_component = {
	provider = {
		name = "file_info",
		opts = {
			type = "relative",
			file_modified_icon = "",
		},
	},
	hl = {
		bg = "bg1",
		fg = "skyblue",
	},
}

local winbar_fileinfo_component_inactive = {
	provider = {
		name = "file_info",
		opts = {
			type = "relative",
			file_modified_icon = "",
		},
	},
	hl = {
		bg = "bg1",
		fg = "fg",
	},
}

local winbar_components = {
	active = {},
	inactive = {},
}

-- add a section to each one
table.insert(winbar_components.active, {})
table.insert(winbar_components.inactive, {})

table.insert(winbar_components.active[1], winbar_fileinfo_component)
table.insert(winbar_components.inactive[1], winbar_fileinfo_component_inactive)

feline.winbar.setup({
	components = winbar_components,
})
