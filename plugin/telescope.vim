lua require("alpha")

let g:telescope_cache_results = 1
let g:telescope_prime_fuzzy_find  = 1

nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <leader>pw :lua require('telescope.builtin').grep_string({ search = vim.fn.expand("<cword>")})<CR>

nnoremap <leader>pp :lua require('telescope.builtin').git_files()<CR>
nnoremap <leader>po :lua require('telescope.builtin').find_files()<CR>

nnoremap <leader>pv :lua require('telescope.builtin').lsp_workspace_symbols({ query = vim.fn.input("Symbols > ")})<CR>

nnoremap <leader>pe :lua require('alpha.telescope').buffers()<CR>

nnoremap <leader>bb :lua require('telescope.builtin').file_browser()<CR>

nnoremap <leader>gc :lua require('telescope.builtin').git_branches()<CR>
nnoremap <leader>gs :lua require('telescope.builtin').git_status()<CR>

nnoremap <leader>rc :lua require('alpha.telescope').search_config()<CR>

nnoremap <leader>vrr :lua require('telescope.builtin').lsp_references()<CR>

nnoremap <leader>vs :lua require('telescope.builtin').lsp_document_symbols()<CR>
nnoremap <leader>ve :lua require('telescope.builtin').lsp_document_diagnostics()<CR>
