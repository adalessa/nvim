local color = vim.g.alpha_color

if color == nil then
    print("No color configure, set vim.g.alpha_color and ensure the file exists on the color folder")
    return
end

local ok, colorClass = pcall(require, "alpha.colors."..color)
if not ok then
    print("No setup class for color " .. color)
    return
end

if type(colorClass.setup) ~= "function" then
    print("method setup non existing")
    return
end

colorClass.setup()
