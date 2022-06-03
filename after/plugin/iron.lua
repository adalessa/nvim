local ok, iron = pcall(require, "iron.core")

if not ok then
	return
end

iron.setup({
	config = {
		highlight_last = "IronLastSent",
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
		send_line = "<space>sl",
		send_mark = "<space>s.",
		cr = "<space>s<cr>",
		interrupt = "<space>s<space>",
		exit = "<space>sq",
		clear = "<space>cl",
	},
})
