local ok, null_ls = pcall(require, "null-ls")
if not ok then
    return
end

local composer = require("composer")
local php_actions = require("php-code-actions")
local laravel_actions = require("laravel.code-actions")


local sources = {
    -- null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.formatting.stylua,
    -- null_ls.builtins.diagnostics.eslint,
    -- null_ls.builtins.formatting.phpcsfixer,
    null_ls.builtins.diagnostics.golangci_lint,
    null_ls.builtins.diagnostics.codespell.with({
    	args = { "--ignore-words-list", "crate" },
    }),
    null_ls.builtins.formatting.jq,
    null_ls.builtins.code_actions.gitrebase,
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.formatting.sql_formatter,
    php_actions.getter_setter,
    php_actions.file_creator,
}

-- Maybe sources per type of project
local laravel_sources = {
    null_ls.builtins.diagnostics.phpstan.with({
        command = "./vendor/bin/phpstan",
        to_temp_file = false,
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    }),
    null_ls.builtins.formatting.pint,
    null_ls.builtins.formatting.blade_formatter,
    laravel_actions.relationships,
}

local symonfy_sources = {
    null_ls.builtins.diagnostics.phpstan.with({
        command = "./bin/phpstan",
        to_temp_file = false,
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    }),
    null_ls.builtins.diagnostics.phpcs.with({
        command = "./bin/phpcs",
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    }),
}

if composer.query({ "require", "symfony/framework-bundle" }) ~= nil then
    for _, source in ipairs(symonfy_sources) do
        table.insert(sources, source)
    end
end

if composer.query({ "require", "laravel/framework" }) ~= nil then
    for _, source in ipairs(laravel_sources) do
        table.insert(sources, source)
    end
end

-- Only for development to reload sources
-- null_ls.reset_sources()
-- null_ls.register(sources)

null_ls.setup({
    sources = sources,
    debug = true,
})
