return {
  "vimwiki/vimwiki",
  cmd = { "VimwikiIndex" },
  init = function()
    vim.g.vimwiki_list = {{
      path = "/mnt/nas/alpha/wiki",
      syntax = "markdown",
      ext = ".md",
    }}
    vim.g.vimwiki_global_ext = 0
  end,
}
