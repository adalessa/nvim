local ok, tokyonight = pcall(require, "tokyonight")
if not ok then
    return
end

tokyonight.setup({
    style="night"
})

vim.cmd.colorscheme("tokyonight")
