local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local configs = "plugins"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
  configs, 

  {
    defaults = {
      lazy = true,
    },

    ui = {
      title = "Plugin Manager",
      title_pos = "center",

      icons = {
        cmd = " ",
        config = "",
        event = "",
        ft = " ",
        init = " ",
        import = " ",
        keys = " ",
        lazy = "󰂠 ",
        loaded = "●",
        not_loaded = "○",
        plugin = " ",
        runtime = " ",
        source = " ",
        start = "",
        task = "✔ ",

        list = {
          "●",
          "➜",
          "★",
          "‒",
        },
      },
    },
  }
)

