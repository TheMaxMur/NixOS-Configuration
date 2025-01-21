return {
	{
		"shaunsingh/nord.nvim",
		enable = true,
		lazy = false,

		config = function()
			vim.cmd([[colorscheme nord]])
		end,
	},
}
