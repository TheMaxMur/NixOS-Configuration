vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.expandtab = true

local function check_git_repo()
	local cmd = "git rev-parse --is-inside-work-tree"
	if vim.fn.system(cmd) == "true\n" then
		vim.api.nvim_exec_autocmds("User", { pattern = "InGitRepo" })
		return true
	end
end

vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
	callback = function()
		vim.schedule(check_git_repo)
	end,
})

