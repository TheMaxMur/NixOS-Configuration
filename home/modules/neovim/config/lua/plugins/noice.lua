return {
	{
		"folke/noice.nvim",
		version = "4.4.7",
		event = "VimEnter",
		enabled = not vim.g.started_by_firenvim,

		opts = {
			lsp = {
				signature = {
					enabled = true,
				},
			},
			presets = {
				lsp_doc_border = true,
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = true,
			},
		},
		dependencies = {
			{
				"rcarriga/nvim-notify",
				config = function()
					require("notify").setup({
						minimum_width = 50,
						background_colour = "#1d2021",
						stages = "static",
						render = "minimal",
						timeout = 1500,
					})
					local notify = require("notify")
					vim.notify = notify
				end,
			},
			{
				"MunifTanjim/nui.nvim",
			},
		},
	},

	vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = "#dcd7ba" }),
	vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { fg = "#dcd7ba" }),
	vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = "#dcd7ba" }),
}
