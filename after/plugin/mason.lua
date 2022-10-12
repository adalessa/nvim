local ok, mason = pcall(require, "mason")
if not ok then
	return
end

local mason_lspconfig = require("mason-lspconfig")

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

mason_lspconfig.setup({
	automatic_installation = false,
})

require('mason-tool-installer').setup {

  -- a list of all tools you want to ensure are installed upon
  -- start; they should be the names Mason uses for each tool
  ensure_installed = {
    "blade-formatter",
    "codespell",
    "dockerfile-language-server",
    "emmet-ls",
    "go-debug-adapter",
    "golangci-lint",
    "gopls",
    "html-lsp",
    "intelephense",
    "json-lsp",
    "lua-language-server",
    "php-debug-adapter",
    "rust-analyzer",
    "stylua",
    "typescript-language-server",
    "vue-language-server",
    -- "phpactor",
    "sql-formatter",
  },

  -- if set to true this will check each tool for updates. If updates
  -- are available the tool will be updated. This setting does not
  -- affect :MasonToolsUpdate or :MasonToolsInstall.
  -- Default: false
  auto_update = false,

  -- automatically install / update on startup. If set to false nothing
  -- will happen on startup. You can use :MasonToolsInstall or
  -- :MasonToolsUpdate to install tools and check for updates.
  -- Default: true
  run_on_start = true,

  -- set a delay (in ms) before the installation starts. This is only
  -- effective if run_on_start is set to true.
  -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
  -- Default: 0
  start_delay = 3000, -- 3 second delay
}
