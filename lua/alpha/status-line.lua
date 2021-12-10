require('lualine').setup{
    options = {
      theme = 'dracula',
      icons_enabled = true,
    },
    extensions = {'quickfix', 'fugitive'},
    sections = {
      lualine_a = { { 'mode', upper = true } },
      lualine_b = { { 'branch', icon = '' }, 'diff' },
      lualine_c = { { 'filename', file_status = true, path = 1 } },
      lualine_x = { { 'diagnostics', sources = { 'nvim_diagnostic' } },'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_a = {  },
      lualine_b = {  },
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {  },
      lualine_z = {  },
    },
    -- tabline = {
    --   lualine_a = {'buffers'},
    --   lualine_b = {},
    --   lualine_c = {},
    --   lualine_x = {},
    --   lualine_y = {},
    --   lualine_z = {'tabs'}
    -- }
    }
