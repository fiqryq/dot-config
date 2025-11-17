return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  event = "VimEnter",
  opts = {
    dashboard = { enabled = true },
    explorer = { enabled = true },
    statuscolumn = { enabled = true },
    scroll = { enabled = true },
    indent = {
      enabled = false,
      chunk = {
        enabled = true,
        char = {
          corner_top = "╭",
          corner_bottom = "╰",
          horizontal = "─",
          arrow = ">",
        },
      },
    },
  },
}
