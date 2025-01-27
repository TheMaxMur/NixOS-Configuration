local autocmd = vim.api.nvim_create_autocmd

autocmd({ "VimLeave", "VimSuspend" }, {
	pattern = "*",
	command = "set guicursor=a:ver25",
})
