local ok, null_ls = pcall(require, "null-ls")

if not ok then
    return
end

local my_sources = require("alpha.php_code_actions")

local sources = {
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.diagnostics.phpstan,
    null_ls.builtins.formatting.phpcsfixer,
    null_ls.builtins.diagnostics.golangci_lint,
    -- null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.jq,
    null_ls.builtins.code_actions.gitrebase,
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.completion.luasnip,

    my_sources.php_setter_getter_actions,
}

null_ls.setup({
    sources = sources,
})
