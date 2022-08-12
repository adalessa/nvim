local ok, nightfox = pcall(require, "nightfox")
if not ok then
	return
end

-- vim.cmd("set background=dark")
-- vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
-- vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE")


local palettes = {
    all = {
    }
}

local groups = {
	all = {
		CmpItemAbbr = { fg = "fg0" },
		CmpItemAbbrDeprecated = { link = "Error" },
        CmpItemAbbrMatchFuzzy = { link = "CmpItemAbbr" },
        CmpItemKind = { link = "Special" },
	},
}

nightfox.setup({
	options = {
		styles = {
			comments = "italic",
			keywords = "bold",
			types = "italic,bold",
		},
	},
    palettes = palettes,
	groups = groups,
})

vim.cmd("colorscheme duskfox")
