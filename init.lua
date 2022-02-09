pcall(require, "impatient")

if require "alpha.first_load"() then
  return
end

vim.g.mapleader = " "

vim.g.snippets = "luasnip"

require "alpha.globals"

require "alpha.disable_builtin"

require "alpha.plugins"

-- require "alpha.lsp"

-- require "alpha.telescope"
-- maybe here set up and mapping // need to check tj config
