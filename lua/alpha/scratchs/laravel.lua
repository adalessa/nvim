-- I want to improve a quality of life on controllers
-- Want to show the uri beside de controller
-- Why just stetics
--
-- Give a warning if the controller is missing some assigned routes
--

-- Snippet for creating relationships
-- A select node for the type of relation on the return type
-- base on that node which function should call
-- base on the name and type create the name??
--
-- Want to have something to do with docker and projects
--
-- Problem when I switch project sail is runnin in another one
--
-- local artisan = R "laravel.artisan"
--
-- P(artisan.commands(true))

-- local keys = vim.api.nvim_replace_termcodes("<c-c>", true, false, true)
-- vim.api.nvim_chan_send(63, keys)
-- vim.cmd([[call chansend(23, "\<c-c>")]])

-- P(require("laravel.app").jobs)

local keys = vim.api.nvim_replace_termcodes("<c-c>", true, false, true)
-- foreach open task do this
for _, job in ipairs(require("laravel.app").jobs) do
  vim.api.nvim_chan_send(job, keys)
end
