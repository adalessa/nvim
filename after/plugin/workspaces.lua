-- local ok, workspaces = pcall(require, "workspaces")
-- if not ok then
--     return
-- end

-- local scandir = require("plenary.scandir")


-- require("sessions").setup({
--     events = {"WinEnter", "BufEnter", "BufWritePost" },
--     session_filepath = ".nvim/session",
-- })
-- workspaces.setup({
--     hooks = {
--         open = function()
--           require("sessions").load(nil, { silent = true })
--         end,
--     }
-- })


-- local ws = workspaces.get()
-- local function workspace_exists(name)
--     for _, workspace in ipairs(ws) do
--         if workspace.name == name then
--             return true
--         end
--     end
--     return false
-- end


-- local dirs = scandir.scan_dir(
--     { "/home/alpha/code/php" },
--     { depth = 1, only_dirs = true }
-- )

-- for _, path in ipairs(dirs) do
--     local name = "[PHP]" .. vim.fs.basename(path)
--     if not workspace_exists(name) then
--         workspaces.add(name, path)
--     end
-- end
