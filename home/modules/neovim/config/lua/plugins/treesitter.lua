return {
  {
    "nvim-treesitter/nvim-treesitter",
    enable = true,
    lazy = false,

    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c",
          "go",
          "tsx",
          "cpp",
          "lua",
          "nix",
          "yaml",
          "json",
          "cmake",
          "python",
          "typescript",
          "javascript"
        },

        ignore_install = {},

        highlight = {
          enable = true,
          disable = { "help" },
        },

        indent = {
          enable = true,
        },
      })
    end,
  },
}

