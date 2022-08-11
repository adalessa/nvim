local scandir = require("plenary.scandir")



local dirs = scandir.scan_dir(
    { "/home/alpha/code/php" },
    { depth = 1, only_dirs = true }
)

for _, dir in ipairs(dirs) do
    P(vim.fs.basename(dir))
end
