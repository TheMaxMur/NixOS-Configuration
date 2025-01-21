return {
	{
		"Pocco81/auto-save.nvim",
		enable = true,
		lazy = false,

		config = function()
			local autosave = require("auto-save")

			autosave.setup({
				enabled = true,
				execution_message = {
					message = function() -- message to print on save
						return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
					end,

					dim = 0.18, -- dim the color of `message`
					cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
				},

				events = { "InsertLeave", "TextChanged" },
				conditions = {
					exists = true,
					filename_is_not = {},
					filetype_is_not = {},
					modifiable = true,
				},

				write_all_buffers = false,
				on_off_commands = true,
				clean_command_line_interval = 0,
				debounce_delay = 135,
			})
		end,
	},
}
