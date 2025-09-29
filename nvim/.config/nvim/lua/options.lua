require "nvchad.options"


-- CONFIGURACIÓN NEOVIM ==================================================================

-- Líneas y numeración
vim.opt.number = true                -- Habilita números de línea
vim.opt.relativenumber = true        -- Habilita números relativos

-- Configuración del ratón
vim.opt.mouse = "a"                  -- Habilita el uso del ratón
vim.opt.mousemoveevent = true        -- Permite eventos de movimiento del ratón

-- Indentación
vim.opt.tabstop = 2                  -- Número de espacios por tabulación
vim.opt.softtabstop = 2              -- Espacios al borrar tabulaciones
vim.opt.shiftwidth = 2               -- Espacios al indentar
vim.opt.expandtab = true             -- Convierte tabulaciones en espacios
-- vim.opt.autoindent = true            -- Copia la indentación de la línea anterior
vim.opt.smartindent = true           -- Indenta automáticamente según el código
vim.opt.smarttab = true              -- Usa tabulaciones inteligentes

-- Interfaz
-- vim.opt.scrolloff = 8                -- Mantiene 8 líneas visibles alrededor del cursor
vim.opt.wrap = false                 -- Deshabilita el ajuste de línea
vim.opt.signcolumn = "yes"           -- Siempre muestra la columna de signos
-- vim.opt.foldcolumn = "1"             -- Muestra una columna de pliegues
-- vim.opt.colorcolumn = "80"           -- NO FUNCIONA?
vim.g.have_nerd_font = true
-- vim.g.custom_lualine_show_lsp_names = true  -- Muestra lsp-servers en lualine

-- Modo y apariencia
vim.opt.showmode = false             -- Lualine se encarga de mostrar el modo activo
vim.opt.termguicolors = true

-- Búsquedas
vim.opt.ignorecase = true            -- Búsqueda insensible a mayúsculas
vim.opt.smartcase = true             -- Sensible si hay mayúsculas
-- CursorLine showing
-- vim.o.cursorlineopt = "both"

-- Sustituciones
vim.opt.inccommand = 'nosplit'       -- Vista previa de sustituciones

-- Edición
vim.opt.breakindent = true           -- Mantiene indentación en líneas largas
vim.opt.formatoptions:remove({ 'o' })-- Evita insertar comentarios en nuevas líneas
vim.api.nvim_create_autocmd('BufEnter', {
    callback = function() vim.opt_local.formatoptions:remove({ 'o' }) end,
    desc = 'Evita comentarios en líneas nuevas',
})

-- Copias de respaldo y undoo tree
vim.opt.swapfile = false
vim.opt.backup = false
-- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true              -- Historial de deshacer persistente

-- Rendimiento
vim.opt.updatetime = 50          -- Menor tiempo para actualizaciones

-- Recommended session options from auto-sessions
vim.opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

-- vim.opt.list = true                  -- Muestra caracteres invisibles

-- vim.opt.fillchars = {                -- Personaliza elementos visuales
--     foldopen = '',
--     foldclose = '',
--     fold = ' ',
--     foldsep = ' ',
--     eob = ' ',
--     diff = '╱',
-- }


-- CLIPBOARD

-- Usar clip.exe para enlazar el clipboard del sistema
vim.g.clipboard = {
  name = 'WslClipboard',
  copy = {
    ['+'] = '/mnt/c/Windows/System32/clip.exe',
    ['*'] = '/mnt/c/Windows/System32/clip.exe',
  },
  paste = {
    -- ['+'] = 'pwsh.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    -- ['*'] = 'pwsh.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    ['+'] = '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write((Get-Clipboard -Raw).ToString().Replace("`r",""))',
    ['*'] = '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write((Get-Clipboard -Raw).ToString().Replace("`r",""))',
  },
  cache_enabled = 0,
}

-- Aquí lo dejamos vacío para que `p` pegue siempre de Neovim, no del sistema
vim.opt.clipboard = ""


-- UFO folding
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- Guarda y restaura folds automáticamente por buffer
vim.opt.viewoptions = "cursor,folds,slash,unix"
