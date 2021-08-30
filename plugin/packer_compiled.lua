-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/alpha/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/alpha/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/alpha/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/alpha/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/alpha/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/LuaSnip"
  },
  delimitMate = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/delimitMate"
  },
  ["emmet-vim"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/emmet-vim"
  },
  gruvbox = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/gruvbox"
  },
  harpoon = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/harpoon"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  neoformat = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/neoformat"
  },
  ["nightfox.nvim"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/nightfox.nvim"
  },
  ["nvim-compe"] = {
    config = { "\27LJ\1\2µ\2\0\0\3\0\6\0\t4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\1>\0\2\1G\0\1\0\vsource\1\0\b\14ultisnips\1\rnvim_lua\2\rnvim_lsp\2\vbuffer\2\nvsnip\1\tcalc\2\fluasnip\2\tpath\2\1\0\v\20resolve_timeout\3†\6\19source_timeout\3»\1\14preselect\venable\ndebug\1\17autocomplete\2\19max_abbr_width\3d\21incomplete_delay\3ê\3\19max_kind_width\3d\18throttle_time\3P\15min_lenght\3\1\venable\2\nsetup\ncompe\frequire\0" },
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/nvim-dap"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["refactoring.nvim"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/refactoring.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["twilight.nvim"] = {
    config = { "\27LJ\1\2¯\1\0\0\3\0\6\0\t4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\1>\0\2\1G\0\1\0\vexpand\1\v\0\0\25function_declaration\29function_call_expression\25expression_statement\rfunction\24function_definition\23method_declaration\vmethod\ntable\17if_statement\21type_declaration\1\0\1\fcontext\3\3\nsetup\rtwilight\frequire\0" },
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/twilight.nvim"
  },
  ["vim-blade"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/vim-blade"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-composer"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/vim-composer"
  },
  ["vim-dadbod"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/vim-dadbod"
  },
  ["vim-dispatch"] = {
    commands = { "Dispatch", "Make", "Focus", "Start" },
    loaded = false,
    needs_bufread = false,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/opt/vim-dispatch"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/vim-eunuch"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-gitgutter"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/vim-gitgutter"
  },
  ["vim-go"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/vim-go"
  },
  ["vim-http"] = {
    commands = { "Http" },
    loaded = false,
    needs_bufread = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/opt/vim-http"
  },
  ["vim-kitty"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/vim-kitty"
  },
  ["vim-laravel"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/vim-laravel"
  },
  ["vim-maximizer"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/vim-maximizer"
  },
  ["vim-obsession"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/vim-obsession"
  },
  ["vim-projectionist"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/vim-projectionist"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-tbone"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/vim-tbone"
  },
  ["vim-terraform"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/vim-terraform"
  },
  ["vim-test"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/vim-test"
  },
  ["vim-vinegar"] = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/vim-vinegar"
  },
  vimspector = {
    loaded = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/start/vimspector"
  },
  vimwiki = {
    commands = { "VimwikiIndex" },
    loaded = false,
    needs_bufread = true,
    path = "/home/alpha/.local/share/nvim/site/pack/packer/opt/vimwiki"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: twilight.nvim
time([[Config for twilight.nvim]], true)
try_loadstring("\27LJ\1\2¯\1\0\0\3\0\6\0\t4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\1>\0\2\1G\0\1\0\vexpand\1\v\0\0\25function_declaration\29function_call_expression\25expression_statement\rfunction\24function_definition\23method_declaration\vmethod\ntable\17if_statement\21type_declaration\1\0\1\fcontext\3\3\nsetup\rtwilight\frequire\0", "config", "twilight.nvim")
time([[Config for twilight.nvim]], false)
-- Config for: nvim-compe
time([[Config for nvim-compe]], true)
try_loadstring("\27LJ\1\2µ\2\0\0\3\0\6\0\t4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\1>\0\2\1G\0\1\0\vsource\1\0\b\14ultisnips\1\rnvim_lua\2\rnvim_lsp\2\vbuffer\2\nvsnip\1\tcalc\2\fluasnip\2\tpath\2\1\0\v\20resolve_timeout\3†\6\19source_timeout\3»\1\14preselect\venable\ndebug\1\17autocomplete\2\19max_abbr_width\3d\21incomplete_delay\3ê\3\19max_kind_width\3d\18throttle_time\3P\15min_lenght\3\1\venable\2\nsetup\ncompe\frequire\0", "config", "nvim-compe")
time([[Config for nvim-compe]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file Make lua require("packer.load")({'vim-dispatch'}, { cmd = "Make", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file Focus lua require("packer.load")({'vim-dispatch'}, { cmd = "Focus", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file Http lua require("packer.load")({'vim-http'}, { cmd = "Http", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file VimwikiIndex lua require("packer.load")({'vimwiki'}, { cmd = "VimwikiIndex", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file Dispatch lua require("packer.load")({'vim-dispatch'}, { cmd = "Dispatch", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file Start lua require("packer.load")({'vim-dispatch'}, { cmd = "Start", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
