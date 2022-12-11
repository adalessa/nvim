function reverse_current_word()
    local line = vim.fn.getline('.')
    local current_word = vim.fn.expand('<cword>')
    local start_index = vim.fn.col('.') - #current_word + 1
    local reversed_word = current_word:reverse()

    local reversed_line = line:sub(1, start_index -1)..reversed_word..line:sub(start_index+#current_word)
    P(reversed_line)
    vim.fn.setline('.', reversed_line)
end

vim.api.nvim_command('command! -range=% ReverseWord :<line1>,<line2>lua reverse_current_word()')

-- testing
