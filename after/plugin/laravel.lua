local ok, laravel = pcall(require, "laravel")
if not ok then
	return
end

laravel.setup()

vim.keymap.set("n", "<leader>ac", function()
	require("laravel.artisan").clean_cmd_list_cache()
	require("notify").notify("Artisan cmd list cache clean", "info", { title = "Laravel.nvim" })
end, { noremap = true })
