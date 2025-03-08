local autocmd = vim.api.nvim_create_autocmd
local function check_git_repo()
	local cmd = "git rev-parse --is-inside-work-tree"
	if vim.fn.system(cmd) == "true\n" then
		vim.api.nvim_exec_autocmds("User", { pattern = "InGitRepo" })
		return true
	end
end

autocmd({ "VimEnter", "DirChanged" }, {
	callback = function()
		vim.schedule(check_git_repo)
	end,
})

autocmd({ "VimLeave", "VimSuspend" }, {
	pattern = "*",
	command = "set guicursor=a:ver25",
})
