local ok, laravel = pcall(require, "laravel")
if not ok then
	return
end

laravel.setup()
