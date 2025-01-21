return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				"natecraddock/telescope-zf-native.nvim",
			},
		},
		cmd = "Telescope oldfiles",
		keys = {
			{
				";f",
				function()
					local builtin = require("telescope.builtin")
					builtin.find_files({
						no_ignore = false,
						hidden = true,
					})
				end,
				desc = "Lists files in your current working directory, respects .gitignore",
			},
			{
				";r",
				function()
					local builtin = require("telescope.builtin")
					builtin.live_grep({
						additional_args = { "--hidden" },
					})
				end,
				desc = "Live Grep",
			},
			{
				";;",
				function()
					local builtin = require("telescope.builtin")
					builtin.resume()
				end,
				desc = "Resume the previous telescope picker",
			},
			{
				";s",
				function()
					local builtin = require("telescope.builtin")
					builtin.treesitter()
				end,
				desc = "Lists Function names, variables, from Treesitter",
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				extensions = {
					["zf-native"] = {
						file = {
							enable = true,
							highlight_results = true,
							match_filename = true,
							initial_sort = nil,
							smart_case = true,
						},
					},
				},
				defaults = {
					wrap_results = false,
					prompt_prefix = "   ",
					selection_caret = "  ",
					entry_prefix = "  ",
					layout_strategy = "horizontal",
					sorting_strategy = "ascending",
					winblend = 0,
					mappings = {
						n = {
							["q"] = "close",
						},
					},
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.5,
							results_width = 0.6,
						},
						width = 0.85,
						height = 0.70,
						preview_cutoff = 120,
					},
				},
			})
			require("telescope").load_extension("zf-native")
		end,
	},
}
