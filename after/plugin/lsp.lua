local telescope_mapper = require("alpha.telescope.mappings")

local lsp_formatting = function(bufnr, allowed_clientes)
	vim.lsp.buf.format({
		filter = function(client)
			for _, value in pairs(allowed_clientes) do
				if client.name == value then
					return true
				end
			end

			return false
		end,
		bufnr = bufnr,
	})
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local format_on_save = function(allowed_clients)
	return function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr, allowed_clients)
				end,
			})
		end
	end
end

local filetype_attach = setmetatable({
	go = format_on_save({ "gopls" }),
	-- php = format_on_save,
	-- lua = format_on_save,

	gdscript = function(_) end,
}, {
	__index = function()
		return function() end
	end,
})

-- Since I use null os this allows to have the format and actions
-- in all buffers not just configured servers
vim.keymap.set({ "n", "v" }, "<leader>vca", vim.lsp.buf.code_action, {})

vim.keymap.set("n", "<leader>vf", function()
	return vim.lsp.buf.format({ async = true })
end, {})

vim.keymap.set("n", "<leader>vn", vim.diagnostic.goto_next, {})
vim.keymap.set("n", "<leader>vp", vim.diagnostic.goto_prev, {})

local function on_attach(client, bufnr)
	local filetype = vim.api.nvim_buf_get_option(0, "filetype")
	-- keymaps for lsp
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
	vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, { buffer = 0 })
	vim.keymap.set("n", "<leader><c-]>", function()
		vim.cmd("vsp")
		vim.lsp.buf.definition()
	end, { buffer = 0 })
	vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, { buffer = 0 })
	vim.keymap.set("i", "<c-h>", vim.lsp.buf.signature_help, { buffer = 0 })
	vim.keymap.set("n", "<leader>vo", ":LspRestart<cr>", { noremap = true })

	telescope_mapper("gr", "lsp_references", nil, true)
	telescope_mapper("<leader>pv", "find_symbol", nil, true)
	telescope_mapper("<leader>pd", "lsp_document_symbols", nil, true)

	vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

	-- Attach any filetype specific options to the client
	filetype_attach[filetype](client, bufnr)
end

vim.diagnostic.config({
	virtual_text = false,
})

local signs = { Error = "⛔", Warn = "⚠️", Hint = "💡", Info = "ℹ️" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Actual configs
local lsp_flags = {
	debounce_text_changes = 150,
}

-- Server configurations

require("lspconfig")["rust_analyzer"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	-- Server-specific settings...
	settings = {
		["rust-analyzer"] = {},
	},
})

require("lspconfig").dockerls.setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

-- require("lspconfig")["intelephense"].setup({
-- 	on_attach = on_attach,
-- 	flags = lsp_flags,
-- })

require("lspconfig")["phpactor"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

require("lspconfig").jsonls.setup({
	on_attach = on_attach,
	flags = lsp_flags,
})
require("lspconfig").html.setup({
	on_attach = on_attach,
	flags = lsp_flags,
})
require("lspconfig").html.setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").emmet_ls.setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "blade" },
})

require("lspconfig").gopls.setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

require("lspconfig").gdscript.setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

require("lspconfig").tsserver.setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

require("lspconfig").volar.setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

require("lspconfig")["sumneko_lua"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
})
