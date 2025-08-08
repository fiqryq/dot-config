return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  event = "VimEnter",
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      sections = {
        {
          section = "terminal",
          cmd = "test -f ~/.cache/nvim/dashboard.txt && cat ~/.cache/nvim/dashboard.txt || (chafa ~/.config/nvim/background/background.png --format symbols --symbols vhalf --size 60x17 --stretch | tee ~/.cache/nvim/dashboard.txt)",
          height = 17,
          padding = 1,
        },
        {
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
    },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
}
