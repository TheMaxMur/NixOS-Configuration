return {
	{
		"echasnovski/mini.nvim",
		event = { "BufReadPre" },
		config = function()
			require("mini.align").setup()
		end,
	},
}
