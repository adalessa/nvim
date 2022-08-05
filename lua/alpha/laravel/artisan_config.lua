local config = {
    has_composer = false,
    is_laravel = false,
    is_sail = false,
    artisan_cmd = nil
}

if vim.fn.findfile("composer.json") == nil then
    return config
end

config.has_composer = true;


local composer_json = vim.fn.json_decode(vim.fn.readfile(vim.fn.getcwd() .. "/composer.json"))
if composer_json["require"]["laravel/framework"] == nil then
    return config
end
config.is_laravel = true

local artisan_command
if composer_json["require-dev"]["laravel/sail"] ~= nil then
    config.is_sail = true
    config.artisan_cmd = "sail"
else
    config.artisan_cmd = "php"
end

return config
