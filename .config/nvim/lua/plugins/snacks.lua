return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  event = "VimEnter",
  opts = function()
    local img = vim.fn.expand "~/.config/nvim/background/background.png"
    local cache = vim.fn.stdpath "cache" .. "/dashboard.txt"

    local cmd = table.concat({
      'if [ -f "' .. cache .. '" ]; then',
      '  cat "' .. cache .. '";',
      "else",
      '  chafa "'
        .. img
        .. '" --format symbols --symbols vhalf --size 60x17 --stretch --animate off | tee "'
        .. cache
        .. '";',
      "fi",
    }, " ")

    return {
      dashboard = {
        enabled = true,
        sections = {
          {
            section = "terminal",
            cmd = cmd,
            height = 17,
            padding = 1,
          },
          {
            { section = "keys", gap = 1, padding = 1 },
            { section = "startup" },
          },
        },
      },
    }
  end,
}
