local default_font = "JetbrainsMono Nerd Font"
local default_size = 14;

vim.g.neovide_transparency = 0.9
vim.o.guifont="JetbrainsMono Nerd Font:h20"
vim.g.neovide_hide_mouse_when_typing = true

local function set_font(font, size)
    font = font or default_font
    size = size or default_size

    vim.o.guifont = string.format("%s:h%d", font, size)
end

set_font()

local maps = {
    f0 = 14,
    f1 = 15,
    f2 = 16,
    f3 = 17,
    f4 = 18,
    f5 = 19,
}

for key, value in pairs(maps) do
    vim.keymap.set("n", "<leader>" .. key, function ()
        set_font(nil, value)
    end)
end
