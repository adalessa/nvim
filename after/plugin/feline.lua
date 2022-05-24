local ok, feline = pcall(require, "feline")
if not ok then
  return
end

local my_theme = {
    bg = '#131a24',
    bg1 = '#192330',
    black = '#131a24',
    skyblue = '#719cd6',
    cyan = '#63cdcf',
    fg = '#aeafb0',
    green = '#81b29a',
    magenta = '#9d79d6',
    orange = '#f4a261',
    red = '#c94f6d',
    white = '#dfdfe0',
    yellow = '#dbc074',
    oceanblue = "#39506d",
}

feline.setup()
feline.use_theme(my_theme)
feline.winbar.setup({
    components = {
        active = {
            {
                {
                    provider = {
                        name = 'file_info',
                        opts = {
                            type = 'full-path',
                            file_modified_icon = '[M]'
                        },
                    },
                    hl = {
                        bg = 'bg1',
                        fg = 'skyblue',
                    },
                }
            }
        },
        inactive = {
            {
                {
                    provider = {
                        name = 'file_info',
                        opts = {
                            type = 'full-path',
                            file_modified_icon = '[*]'
                        },
                    },
                    hl = {
                        bg = 'bg1',
                        fg = 'fg',
                    },
                }
            }
        }
    }
})
