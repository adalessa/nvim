SHOULD_RELOAD_TELESCOPE = true

local reloader = function()
  if SHOULD_RELOAD_TELESCOPE then
    RELOAD "plenary"
    RELOAD "telescope"
    RELOAD "alpha.telescope.setup"
  end
end

local action_state = require "telescope.actions.state"
local fb_actions = require("telescope").extensions.file_browser.actions
local actions = require "telescope.actions"
local my_actions = require "alpha.telescope.actions"

local M = {}

function M.project_files()
  local opts = { show_untracked = true } -- define here if you want to define something
  local ok = pcall(require("telescope.builtin").git_files, opts)
  if not ok then
    require("telescope.builtin").find_files(opts)
  end
end

function M.branches()
  require("telescope.builtin").git_branches {
    attach_mappings = function(_, map)
      map("i", "<c-j>", actions.git_create_branch)
      map("n", "<c-j>", actions.git_create_branch)
      return true
    end,
  }
end

function M.search_config()
  require("telescope.builtin").git_files {
    prompt_title = "< Dotfiles >",
    cwd = "$HOME/.dotfiles",
    show_untracked = true,
  }
end

M.find_nvim_config = function()
  require("telescope.builtin").find_files {
    prompt_title = "< Neovim >",
    cwd = "$HOME/.config/nvim/",
  }
end

M.find_nvim_plugin = function()
  require("telescope.builtin").find_files {
    prompt_title = "< Plugins >",
    cwd = "$HOME/.config/nvim/lua/plugins/",
    attach_mappings = function(_, map)
      map("i", "<C-t>", my_actions.create_plugin)
      map("i", "<C-d>", my_actions.disable_plugin)
      map("i", "<C-e>", my_actions.enable_plugin)

      return true
    end,
  }
end

function M.grep_string()
  vim.ui.input({ prompt = "Grep for > " }, function(input)
    if input == nil then
      return
    end
    require("telescope.builtin").grep_string { search = input }
  end)
end

function M.grep_word()
  require("telescope.builtin").grep_string { search = vim.fn.expand "<cword>" }
end

function M.find_symbol()
  vim.ui.input({ prompt = "Symbol for > " }, function(input)
    if input == nil then
      return
    end
    require("telescope.builtin").lsp_workspace_symbols { query = input }
  end)
end

function M.my_plugins()
  if vim.fn.isdirectory "~/code/plugins/" == 0 then
    vim.notify("Directory ~/code/plugins does not exists", vim.log.levels.WARN, { title = "Telescope Mappings" })
    return
  end
  require("telescope.builtin").find_files {
    cwd = "~/code/plugins/",
  }
end

function M.projectionist()
  return require("telescope").extensions.projectionist.projectionist()
end

function M.laravel_commands()
  return require("telescope").extensions.laravel.laravel()
end

function M.api_specs()
  if vim.fn.isdirectory "./api-specification" == 0 then
    vim.notify("Directory api-specification does not exists", vim.log.levels.WARN, { title = "Telescope Mappings" })
    return
  end
  require("telescope.builtin").git_files {
    cwd = "./api-specification",
    show_untracked = true,
  }
end

function M.worktree()
  return require("telescope").extensions.git_worktree.git_worktrees()
end

function M.worktree_create()
  return require("telescope").extensions.git_worktree.create_git_worktree()
end

function M.refactor()
  return require("telescope").extensions.refactoring.refactors()
end

function M.file_browser_relative()
  return M.file_browser { path = "%:p:h" }
end

function M.gateway()
  return require("alpha.php.gateway").graphql_definitions {
    layout_config = {
      horizontal = {
        preview_width = function(_, cols, _)
          return math.floor(cols * 0.7)
        end,
      },
    },
  }
end

function M.file_browser(opts)
  opts = opts or {}

  opts = {
    path = opts.path,
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    layout_config = {
      prompt_position = "top",
    },

    attach_mappings = function(_, map)
      map("i", "<c-y>", fb_actions.create)

      return true
    end,
  }

  return require("telescope").extensions.file_browser.file_browser(opts)
end

return setmetatable({}, {
  __index = function(_, k)
    reloader()
    if M[k] then
      return M[k]
    else
      return require("telescope.builtin")[k]
    end
  end,
})
