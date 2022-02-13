local actions = require('telescope.actions')

local M = {}

function M.project_files()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require'telescope.builtin'.git_files, opts)
  if not ok then require'telescope.builtin'.find_files(opts) end
end

function M.branches()
    require'telescope.builtin'.git_branches({ attach_mappings = function(_, map)
      map('i', '<c-j>', actions.git_create_branch)
      map('n', '<c-j>', actions.git_create_branch)
      return true
    end})
end

function M.search_config()
    require("telescope.builtin").git_files({
        prompt_title = "< dotfiles >",
        cwd = "$HOME/.dotfiles",
    })
end

function M.grep_string()
    vim.ui.input("Grep for > ", function (input)
        if input == nil then
            return
        end
        require('telescope.builtin').grep_string({ search = input})
    end)
end

function M.grep_word()
    require('telescope.builtin').grep_string({ search = vim.fn.expand("<cword>")})
end

function M.find_symbol ()
    vim.ui.input("Symbol for > ", function (input)
        if input == nil then
            return
        end
        require('telescope.builtin').lsp_workspace_symbols({ search = input})
    end)
end

function M.my_plugins()
    require("telescope.builtin").find_files {
        cwd = "~/plugins/",
    }
end

return setmetatable({}, {
  __index = function(_, k)

    if M[k] then
      return M[k]
    else
      return require("telescope.builtin")[k]
    end
  end,
})
