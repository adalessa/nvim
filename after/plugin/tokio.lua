local ok, tokionight = pcall(require, "tokyonight")
if not ok then
    return
end

tokionight.setup({
    style="night"
})

vim.cmd[[colorscheme tokyonight]]
