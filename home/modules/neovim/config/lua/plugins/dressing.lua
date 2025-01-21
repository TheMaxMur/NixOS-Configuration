return {
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {
			input = {
				title_pos = "center",
				relative = "cursor",
				insert_only = false,
				start_in_insert = true,
				win_options = {
					wrap = false,
				},
			},
			select = {
				backend = { "builtin" },
				get_config = function(opts)
					if opts.kind == "codeaction" then
						return {
							backend = "builtin",
							builtin = {
								relative = "cursor",
								max_height = 0.30,
								min_height = 3,
								max_width = 0.40,
								mappings = { ["q"] = "Close" },
							},
						}
					end
				end,
				mappings = {
					["<Esc>"] = "Close",
					["<CR>"] = "Confirm",
				},
			},
		},
	},
}
