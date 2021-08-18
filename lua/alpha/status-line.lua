require('lualine').setup{
    options = {
      theme = 'nightfox',
      section_separators = { '', '' },
      component_separators = { '', '' },
      icons_enabled = true,
    },
    sections = {
      lualine_a = { { 'mode', upper = true } },
      lualine_b = { { 'branch', icon = '' } },
      lualine_c = { { 'filename', file_status = true, path = 1 } },
      lualine_x = { { 'diagnostics', sources = { 'nvim_lsp' } },'encoding', 'fileformat', 'filetype' },
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
    }
