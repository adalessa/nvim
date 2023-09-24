return {
  mason = {
    enable = true,
    auto_install = false,
  },
  servers = {
    emmet_ls = { enable = true },
    gopls = { enable = true },
    html = { enable = true },
    jsonls = { enable = true },
    lua_ls = { enable = true, neodev = true },
    nil_ls = { enable = true },
    phpactor = {enable = true },
    rust_analyzer = { enable = true },
    svelte = { enable = true },
    tailwindcss = { enable = true, filetypes = {"blade", "html", "svelte"} },
    tsserver = { enable = true },
    volar = { enable = true },
  },
  default_options = function (options)
    return vim.tbl_deep_extend("force", {
      on_attach = require"alpha.lsp.attach",
      flags = require "alpha.lsp.flags",
    }, options)
  end,
}
