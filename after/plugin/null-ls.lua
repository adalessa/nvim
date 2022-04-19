local ok, null_ls = pcall(require, "null-ls")

if not ok then
	return
end

local sources = {
	null_ls.builtins.code_actions.gitsigns,
	null_ls.builtins.formatting.stylua,
	null_ls.builtins.diagnostics.eslint,
	null_ls.builtins.diagnostics.phpstan,
}

require("alpha.php_code_actions")

null_ls.setup({
	sources = sources,
})
