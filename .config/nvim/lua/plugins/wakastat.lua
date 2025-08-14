return {
  {
    "fiqryq/wakastat.nvim",
    event = "VeryLazy",
    cmd = { "WakastatRefresh", "WakastatStatus" },
    opts = {
      args = { "--today" },
      format = "Session Time: %s",
      update_interval = 300,
      enable_timer = true,
    },

    config = function(_, opts) require("wakastat").setup(opts) end,

    specs = {
      {
        "rebelot/heirline.nvim",
        optional = true,
        opts = function(_, opts)
          opts.statusline = opts.statusline or {}
          table.insert(opts.statusline, 5, {
            provider = function() return " " .. require("wakastat").status() .. " " end,
            hl = "Wakastat",
            update = { "User", pattern = "WakastatUpdated" },
          })
        end,
      },
    },
  },
}
