return {
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {},
	},

	{
		"numToStr/Comment.nvim",
		enabled = true,
		event = { "BufReadPre" },
		dependencies = {
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
				dependencies = { "nvim-treesitter/nvim-treesitter" },
			},
		},
		config = function()
			vim.g.skip_ts_context_commentstring_module = true
			require("Comment").setup({
				toggler = {
					line = "<C-x>",
				},
				opleader = {
					block = "<C-x>",
				},
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
}

