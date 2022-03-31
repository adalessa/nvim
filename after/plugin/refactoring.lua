local ok, refactoring = pcall(require, "refactoring")
if not ok then
	return
end

refactoring.setup({})
