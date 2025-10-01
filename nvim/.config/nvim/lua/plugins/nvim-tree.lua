return {
  {
    "nvim-tree/nvim-tree.lua",
    opts = function(_, opts)
      -- Mostrar SIEMPRE archivos/dirs ignorados por git (toggle "I")
      opts.filters = vim.tbl_deep_extend("force", opts.filters or {}, {
        git_ignored = false,  -- por defecto NvimTree oculta lo ignorado si esto es true
        dotfiles = false,  -- por si también quieres ver .archivos siempre
      })
      -- ancho del panel
      opts.view = vim.tbl_deep_extend("force", opts.view or {}, {
        width = 36,      -- aquí pones el número de columnas que quieras
        side = "left",   -- o "right" si lo quieres en el otro lado
      })
      opts.git = vim.tbl_deep_extend("force", opts.git or {}, {
        enable = true,
        show_on_dirs = false,
        show_on_open_dirs = false,
      })
      opts.modified = { enable = true, show_on_dirs = false, show_on_open_dirs = false }
      opts.renderer = vim.tbl_deep_extend("force", opts.renderer or {}, {
        highlight_git = "name",                 -- "none" | "icon" | "name" | "all" | true
        highlight_modified = "name",            -- "none" | "icon" | "name" | "all" 
        icons = {
          git_placement = "right_align",        -- o "right_align" , "after"
          modified_placement = "after",
          glyphs = {
            modified = "✱",
            git = {
              unstaged  = "M",
              -- unstaged  = "",
              staged    = "",
              unmerged  = "",
              renamed   = "",
              untracked = "U",
              -- untracked = "",
              deleted   = "",
              ignored   = "󰴲",
            },
          },
        },
      })
      return opts
    end,
  },
}
