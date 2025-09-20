return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    { "ff", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "flash" },
    { "ft", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "flash treesitter" },
    { "<leader>Ff", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "flash" },
    { "<leader>Ft", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "flash treesitter" },
  },
  --   { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "toggle flash search" },
}

