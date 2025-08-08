if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    mappings = {
      n = {
        ["<Leader>e"] = {
          function()
            require("neo-tree.command").execute {
              toggle = true,
              position = "float",
              window = { width = vim.fn.winwidth(0) * 0.7 },
            }
          end,
          desc = "Explorer (float)",
        },
      },
    },
  },
}
