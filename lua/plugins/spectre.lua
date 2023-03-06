return {
  "nvim-pack/nvim-spectre",
  keys = {{"<leader>F", function ()
    return require("spectre").open()
  end}},
  config = true,
}
