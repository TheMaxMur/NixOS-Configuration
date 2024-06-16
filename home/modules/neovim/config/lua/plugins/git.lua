return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      {
        "ruifm/gitlinker.nvim",
        config = function()
          require("gitlinker").setup()
        end,
      },
      "sindrets/diffview.nvim",
    },
    event = { "User InGitRepo" },
    config = function()
      require("neogit").setup({
        graph_style = "unicode",
        sort_branches = "-committerdate",
        kind = "replace",
        popup = {
          ["?"] = "HelpPopup",
          ["D"] = "DiffPopup",
          ["P"] = "PushPopup",
          ["Z"] = "StashPopup",
          ["b"] = "BranchPopup",
          ["c"] = "CommitPopup",
          ["l"] = "LogPopup",
          ["p"] = "PullPopup",
        },
      })
    end,
  },
}

