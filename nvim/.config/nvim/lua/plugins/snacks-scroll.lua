return {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
        -- Scroll suave
        scroll = {
           enabled = true,
           animate = {
              duration = { step = 140, total = 140 },
              easing = "linear",
          },
        },
    },
}

