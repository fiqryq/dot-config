return {
  "webhooked/polar.nvim",
  lazy = false,
  priority = 1000,
  enabled = true,
  config = function()
    require("polar").setup {
      transparent = true,
      borders = false,
    }
  end,
}
