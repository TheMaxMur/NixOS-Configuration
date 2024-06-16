return {
	{
		"neovim/nvim-lspconfig",
		enable = true,
    lazy = false,
    -- event = { "VeryLazy" },

		dependencies = {
			"b0o/schemastore.nvim",
      "nvim-lua/plenary.nvim"
		},

		config = function()
            require("lsp.init")
        end,
	},
}

