require("alpha.global")
require("alpha.colors")
require("alpha.telescope")
require("alpha.refactoring")
require("alpha.snippets")
require("alpha.harpoon")
require("alpha.completition")
require("alpha.lsp")
require("alpha.treesitter")
require("alpha.status-line")



-- Keybindings
vim.api.nvim_set_keymap('n', '<leader>rs', ':lua require(\'alpha.refactor\').setter_getter()<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>rn', ':lua require(\'alpha.refactor\').new_property()<cr>', {noremap = true})

vim.api.nvim_set_keymap('n', '<leader><leader>x', ':call alpha#save_and_exec()<cr>', {noremap = true})
