return {
  setup = function(ops)
    ops = vim.tbl_deep_extend("force", require "alpha.lsp.default", ops)

    local lspconfig = require "lspconfig"

    local mason_servers = {}
    for server, options in pairs(ops.servers) do
      if options.enable == true then
        local ok, definition = pcall(require, "alpha.lsp.servers." .. server)
        local server_options
        if not ok then
          server_options = ops.default_options(options)
        else
          server_options = definition(options)
        end
        lspconfig[server].setup(server_options)
        table.insert(mason_servers, server)
      end
    end

    -- Mason
    if ops.mason.enable then
      local mason_ops = {}
      if ops.mason.auto_install == true then
        mason_ops.ensure_installed = mason_servers
      end
      local mason_lspconfig = require "mason-lspconfig"
      mason_lspconfig.setup(mason_ops)
    end

    -- TODO: implement null ls with options
    require "alpha.lsp.null-ls"

    local servers = {}
    for server, options in pairs(ops.servers) do
      table.insert(servers, string.format("%s <%s>", server, options.enable))
    end

    -- TODO: create an auto command that on write of the configuration, calls again the setup and restart the server if it's up.
    -- can get the client by name of the file

    vim.api.nvim_create_user_command("AlphaLSP", function()
      vim.ui.select(servers, { prompt = "LSP Servers" }, function(server)
        if server == nil then
          return
        end

        server = string.match(server, "^(.+) <")
        local path = string.format("%s/lua/alpha/lsp/servers/%s.lua", vim.fn.stdpath "config", server)
        if vim.fn.filereadable(path) == 0 then
          local create = vim.fn.confirm("Server Does Not exist. Create new server?", "&Yes\n&No\n&Cancel")
          if create ~= 1 then
            return
          end
        end

        local uri = vim.uri_from_fname(path)
        local buffer = vim.uri_to_bufnr(uri)

        vim.api.nvim_win_set_buf(0, buffer)
      end)
    end, {})
  end,
}
