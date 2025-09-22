return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- iconos opcionales
  lazy = false,   -- o true si prefieres cargarlo bajo demanda
  opts = {
    default_file_explorer = true, -- reemplaza netrw al hacer :e .
    view_options = {
      show_hidden = true,
    },
    float = {
      padding = 2,
      max_width = 40,
      max_height = 18,
      border = "rounded",
      win_options = { winblend = 1 },
    },
    preview = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      max_height = 0.9,
      min_height = { 5, 0.1 },
      border = "rounded",
      win_options = { winblend = 0 },
    },
    keymaps = {
      ["g?"] = "actions.show_help",
      ["?"]  = "actions.show_help",
      ["<CR>"] = "actions.select",
      -- ["<C-x>"] = { "actions.select", opts = { horizontal = true }, desc = "Abrir en split horizontal" },
      -- ["<C-v>"] = { "actions.select", opts = { vertical = true },   desc = "Abrir en split vertical" },
      -- ["<C-t>"] = { "actions.select", opts = { tab = true },        desc = "Abrir en pestaña nueva" },
      ["<C-c>"] = "actions.close",
      ["<Esc>"] = "actions.close",
      -- ["<C-l>"] = "actions.refresh",
      ["-"]     = "actions.parent",
      ["_"]     = "actions.open_cwd",
      ["`"]     = "actions.cd",
      ["~"]     = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd al directorio de Oil actual", mode = "n" },
      ["gs"]    = "actions.change_sort",
      ["gx"]    = "actions.open_external",
      ["g."]    = "actions.toggle_hidden",
      ["g\\"]   = "actions.toggle_trash",
      -- Si quieres una “preview” lateral:
      -- ["<C-p>"] = { "actions.preview", desc = "Abrir preview" },
    },
  },
  keys = {
    -- Abrir Oil en el directorio del buffer actual (estilo “subir un nivel”)
    { "_", "<cmd>Oil<cr>", desc = "Abrir Oil (directorio padre)" },
    -- Abrir Oil en flotante en el cwd (útil si quieres usar el layout flotante)
    { "-", function() require("oil").open_float(vim.fn.getcwd()) end, desc = "Oil flotante en CWD" },
    -- Shortcut para abrir Oil en la carpeta del buffer en flotante
    { "<leader>of", function() require("oil").open_float(vim.fn.expand("%:p:h")) end, desc = "Oil flotante en carpeta del archivo" },
  },
}

