local M = {}

-- M.diagnostic = function()
--	vim.diagnostic.config(PREF.lsp.diagnostic)
--	for type, icon in pairs(PREF.ui.signs) do
--		local hl = "DiagnosticSign" .. type
--		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
--	end
-- end

local cmp_ok, cmp = pcall(require, "cmp_nvim_lsp")
local ok_c, capabilities = pcall(require("cmp_nvim_lsp").defaults_capabilities)
if cmp_ok and ok_c then
	capabilities.textDocument.complition.complitionItem.snippetSupport = true
	M.capabilities = capabilities
end

M.on_attach = function(client, bufnr)
	local map = function(mode, key, action)
		vim.keymap.set(mode, key, action, { buffer = bufnr, silent = true, noremap = true })
	end
	map("n", "K", vim.lsp.buf.hover)
	-- map("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
	map("n", "gd", vim.lsp.buf.definition)
	map("n", "<leader>rf", vim.lsp.buf.references)
	map("n", "<leader>ca", vim.lsp.buf.code_action)
	map("n", "<leader>rn", vim.lsp.buf.rename)
	map("n", "<space>f", function()
		require("conform").format({ lsp_fallback = true })
	end)

	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		callback = function()
			local float_opts = {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = "rounded",
				source = "always",
				prefix = " ",
			}

			if not vim.b.diagnostics_pos then
				vim.b.diagnostics_pos = { nil, nil }
			end

			local cursor_pos = vim.api.nvim_win_get_cursor(0)
			if
				(cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2])
				and #vim.diagnostic.get() > 0
			then
				vim.diagnostic.open_float(nil, float_opts)
			end

			vim.b.diagnostics_pos = cursor_pos
		end,
	})
end

return M
