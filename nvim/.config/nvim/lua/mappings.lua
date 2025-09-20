require "nvchad.mappings"
-- GENERAL ==============================================
-- KEYMAPS PERSONALIZADOS -------------------------------
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "x", "o" }, "s", "<Nop>")
map({ "n", "x", "o" }, "S", "<Nop>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Insertar una línea en blanco debajo de la línea actual con Enter
vim.keymap.set('n', '<Enter>', 'o<ESC>', { noremap = true, silent = true })

-- Formatea el codigo FUNCIONA?
vim.keymap.set("n", "<leader>ft", vim.lsp.buf.format, { desc = "Formatea el fichero" })

-- Mostrar los registros en la ventana de comandos
vim.keymap.set("n", "<leader>rr", ":registers<CR>", { desc = "Mostrar registros" })

-- Pega y manda lo resaltado al vacio
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Pega y manda lo resaltado al vacio" })

-- Borra y manda al vacio
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d", { desc = "Borra y manda al vacio" })

-- Move Lines
vim.keymap.set('n', '<A-DOWN>', '<cmd>m .+1<cr>==', { desc = 'Move Down' })
vim.keymap.set('n', '<A-UP>', '<cmd>m .-2<cr>==', { desc = 'Move Up' })
vim.keymap.set("x", "<M-Down>", ":m '>+1<CR>gv=gv", { desc = "Move Down" })
vim.keymap.set("x", "<M-Up>",   ":m '<-2<CR>gv=gv", { desc = "Move Up" })

-- J mejorada
vim.keymap.set('n', 'J', 'mzJ`z')

-- Modo visual en bloque con ctrl + shift + v
vim.keymap.set('n', '<C-S-v>', '<C-v>', { noremap = true, silent = true })

-- Seleccionar todo el contenido del fichero Ctrl + a. DESHABILITADO Ctrl + c de NvChad es mejor
-- vim.keymap.set("n", "<C-a>", "ggVG", { noremap = true, silent = true, desc = "Select all content" })

-- Mantiene el cursor en el centro de la pantalla. CONFLICTO con plugin scroll
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Buscar con n/N el resultado quede centrado en pantalla y abre el fold
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- SUSBTITUTTE ------------------------------------------
vim.keymap.set("n", "s", require("substitute").operator, { noremap = true, desc = "Sustituir con movimiento" })
vim.keymap.set("n", "ss", require("substitute").line, { noremap = true, desc = "Sustituir línea actual" })
vim.keymap.set("n", "S", require("substitute").eol, { noremap = true, desc = "Sustituir hasta el final de la línea" })
vim.keymap.set("x", "s", require("substitute").visual, { noremap = true, desc = "Sustituir visualmente" })

vim.keymap.set("n", "<leader>ss", require("substitute").operator, { noremap = true, desc = "Sustituir con movimiento" })
vim.keymap.set("n", "<leader>sl", require("substitute").line, { noremap = true, desc = "Sustituir línea actual" })
vim.keymap.set("n", "<leader>sS", require("substitute").eol, { noremap = true, desc = "Sustituir hasta el final de la línea" })
vim.keymap.set("x", "<leader>s", require("substitute").visual, { noremap = true, desc = "Sustituir visualmente" })

-- VENTANAS ----------------------------------------------
-- Navegar entre ventanas de neovim + tmux panes con "vim-tmux-navigator"
map('n', '<C-h>', ':TmuxNavigateLeft<CR>', { silent = true, desc = 'Move focus to the left window' })
map('n', '<C-l>', ':TmuxNavigateRight<CR>', { silent = true, desc = 'Move focus to the right window' })
map('n', '<C-j>', ':TmuxNavigateDown<CR>', { silent = true, desc = 'Move focus to the lower window' })
map('n', '<C-k>', ':TmuxNavigateUp<CR>', { silent = true, desc = 'Move focus to the upper window' })
-- Resize window using <ctrl> arrow keys NO FUNCIONA
-- vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
-- vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
-- vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
-- vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- En terminal, Esc sale a N-Terminal (equivale a <C-\><C-n>)
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Terminal → Normal" })

-- new terminals OVERRIDES
map("n", "<leader>H", function()
  require("nvchad.term").toggle({ pos = "sp" }) -- "sp" = split horizontal
end, { desc = "Open horizontal terminal" })


-- Disable mappings
local nomap = vim.keymap.del

-- Desactiva el mapping por defecto para <leader>h en modo normal
nomap("n", "<leader>h")

