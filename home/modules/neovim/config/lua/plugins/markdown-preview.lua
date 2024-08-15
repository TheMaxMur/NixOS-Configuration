return {
	{
		"iamcco/markdown-preview.nvim",
		enabled = true,
		build = "cd app && npm install",
		ft = { "markdown" },
		config = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
	},
}

