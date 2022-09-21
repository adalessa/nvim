local ok, null_ls = pcall(require, "null-ls")
if not ok then
	return
end

local composer = require("alpha.composer")
local php_actions = require("php-code-actions")

local sources = {
	null_ls.builtins.code_actions.gitsigns,
	null_ls.builtins.formatting.stylua,
	-- null_ls.builtins.diagnostics.eslint,
	-- null_ls.builtins.formatting.phpcsfixer,
	null_ls.builtins.diagnostics.golangci_lint,
	null_ls.builtins.diagnostics.codespell.with({
		args = { "--ignore-words", "crate" },
	}),
	null_ls.builtins.formatting.jq,
	null_ls.builtins.code_actions.gitrebase,
	null_ls.builtins.code_actions.refactoring,
	null_ls.builtins.formatting.sql_formatter,
	php_actions.getter_setter,
}

-- Maybe sources per type of project
local laravel_sources = {
	null_ls.builtins.diagnostics.phpstan.with({
		command = "./vendor/bin/phpstan",
	}),
	null_ls.builtins.formatting.pint,
	null_ls.builtins.formatting.blade_formatter,
}

local symonfy_sources = {
	null_ls.builtins.diagnostics.phpstan.with({
        command = "./bin/phpstan",
    }),
	null_ls.builtins.diagnostics.phpcs.with({
        command = "./bin/phpcs",
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

null_ls.setup({
	sources = sources,
	debug = true,
})
