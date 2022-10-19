local ok, tokyonight = pcall(require, "tokyonight")
if not ok then
    return
end

local function setup()
    tokyonight.setup({
        style="night"
    })
    vim.cmd.colorscheme("tokyonight")
end

return {
    setup = setup,
}
