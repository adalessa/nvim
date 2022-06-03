local ok, iron = pcall(require, "iron.core")

if not ok then
    return
end

iron.setup({
    config = {
        should_map_plug = false,
        -- Whether a repl should be discarded or not
        scratch_repl = true,
        close_window_on_exit = true,
        -- Your repl definitions come here
        repl_definition = {
            sh = {
                command = { "zsh" },
            },
            javascript = {
                command = { "node" },
            },
            php = {
                command = { "psysh" },
            },
            tinker = {
                command = { "php", "artisan", "tinker" },
            },
            sail = {
                command = { "sail", "tinker" },
            },
        },
        repl_open_cmd = "rightbelow vertical 100 split",
        -- how the REPL window will be opened, the default is opening
        -- a float window of height 40 at the bottom.
    },
    keymaps = {
        send_motion = "<space>sc",
        visual_send = "<space>sc",
        send_file = "<space>sf",
        send_line = "<space>sl",
        send_mark = "<space>sm",
        mark_motion = "<space>mc",
        mark_visual = "<space>mc",
        remove_mark = "<space>md",
        cr = "<space>s<cr>",
        interrupt = "<space>s<space>",
        exit = "<space>sq",
        clear = "<space>cl",
    },
    highlight = {
        italic = true,
    },
})

-- Idea
-- create a menu to ask which console wants to start
-- for php example we have
-- psysh | tinker | tinker on sail
-- base on that save the expected filetype on a buffer variable
-- add the parameter to the command for the IronRepl and all commands to send
-- or beter use my own functions useing the core.* functions
-- not all functions takes the ft as parameter
