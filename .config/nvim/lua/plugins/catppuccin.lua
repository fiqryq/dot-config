if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function() vim.cmd [[colorscheme catppuccin-mocha]] end,
}
