return {
	{
		{
			"lukas-reineke/indent-blankline.nvim",
			event = { "BufReadPost", "BufNewFile" },
			config = function()
				require("ibl").setup({
					indent = {
						char = "▏",
					},
					scope = {
						show_start = false,
						show_end = false,
					},
				})
			end,
			main = "ibl",
		},

		{
			"echasnovski/mini.indentscope",
			enabled = false,
			version = false,
			event = { "BufReadPre", "BufNewFile" },
			opts = {
				symbol = "▏",
				options = { try_as_border = true },
			},
			init = function()
				vim.api.nvim_create_autocmd("FileType", {
					pattern = {
						"help",
						"alpha",
						"dashboard",
						"NvimTree",
						"Trouble",
						"lazy",
						"notify",
						"toggleterm",
						"lazyterm",
					},
					callback = function()
						vim.b.miniindentscope_disable = true
					end,
				})
			end,
		},
	},
}
