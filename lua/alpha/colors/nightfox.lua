local ok, nightfox = pcall(require, "nightfox")
if not ok then
	return
end

local function setup()
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

    vim.cmd.colorscheme("duskfox")
end

return {
    setup = setup,
}
