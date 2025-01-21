local status_ok, lsp = pcall(require, "lspconfig")
if not status_ok then
	return
end

-- require('lsp.handlers').diagnostic()

local servers = {
	"gopls", -- , "nil_ls"
	"lua_ls",
	"jsonls",
	"pyright",
	"yamlls",
	"ansiblels",
	"helm_ls",
	"dockerls",
	"docker_compose_language_service",
	"nixd",
	-- , "gitlab-ci-ls"
}

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("lsp.handlers").on_attach,
		capabilities = require("lsp.handlers").capabilities,
	}
	local has_server_opts, server_opts = pcall(require, "lsp.settings." .. server)
	if has_server_opts then
		opts = vim.tbl_deep_extend("force", server_opts, opts)
	end
	lsp[server].setup(opts)
end
