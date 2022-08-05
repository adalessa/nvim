vim.api.nvim_create_user_command("Artisan", function ()
    local artisan_config = require("alpha.laravel.artisan_config")
    if artisan_config.is_laravel then
        require("alpha.laravel.telescope").picker({})
    end
end, {})

-- TODO
-- move it as plugin folder
-- Add setup fuction and set the global function like "Artisan" or something like that
-- add code actions to create a model
-- or create controller
-- or create any class
-- hover a class the actions could be call the make for that
-- trigger the completition
--
--
-- more searches on telescope or somthing
-- package laravel.nvim
--
-- require("laravel").setup()   ||  initializes the global variable

-- uses the global variable so not to recheck the composer and more
--
-- require("laravel.artisan").run("route:list", {<args>})
-- require("laravel.artisan").make("controller", {<args>})
-- require("laravel.artisan").list() || return the list of commands, mostly to be use as telescope entries
-- require("laravel.artisan").help(<cmd>) || return the help for the command
-- require("laravel.artisan").watch_test("filename") || this will run auto cmd for php files and write.
--
-- can open a new buffer, replace the buffer on the window, delete the previous buffer, put response on the new buffer
--
-- require("laravel.sail").run("<cmd>")
--
-- require("laravel.composer").udpate("library") || optional field
-- require("laravel.composer").install()
-- require("laravel.composer").require()
-- require("laravel.composer").remove()
--
--
-- User commands
-- Could register the user commands for Artisan Sail & Composer
