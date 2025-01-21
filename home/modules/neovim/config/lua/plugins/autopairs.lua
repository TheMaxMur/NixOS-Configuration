return {
	{
		"windwp/nvim-autopairs",
		enabled = true,
		event = "InsertEnter",

		config = function()
			local autopairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")

			autopairs.setup({
				fast_wrap = {},
				disable_filetype = {},
				disable_in_macro = false,
				disable_in_visualblock = false,
				ignored_next_char = [=[[%w%%%'%[%"%.]]=],
				enable_moveright = true,
				enable_afterquote = true,
				enable_check_bracket_line = true,
				enable_bracket_in_quote = true,
				break_undo = true,
				check_ts = true,
				map_cr = true,
				map_bs = true,
				map_c_h = false,
				map_c_w = false,
			})

			autopairs.add_rules({
				Rule(" ", " "):with_pair(function(opts)
					local pair = opts.line:sub(opts.col - 1, opts.col)
					return vim.tbl_contains({ "()", "[]", "{}" }, pair)
				end),
				Rule("|", "|", "rust"),
			})
		end,
	},
}
