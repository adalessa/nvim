-- TODO: remove once 0.9 is more widly available
if vim.fn.has "nvim-0.9.0" ~= 1 then
  vim.treesitter.query.get = vim.treesitter.get_query
  vim.treesitter.query.set = vim.treesitter.set_query
end

require "config"
require "alpha.globals"
