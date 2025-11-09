return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  event = "VimEnter",
  opts = {
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
