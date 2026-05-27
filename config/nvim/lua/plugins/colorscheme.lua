return {
  "webhooked/kanso.nvim",
  enabled = true,
  lazy = false,
  priority = 1000,
  opts = {
    background = {
      light = "mist",
      dark = "ink",
    },
    foreground = {
      light = "saturated",
      dark = "default",
    },
    bold = false,
    italics = true,
    transparent = true,
  },
  config = function(_, opts)
    require("kanso").setup(opts)
    vim.cmd("colorscheme kanso-ink")
  end,
}
