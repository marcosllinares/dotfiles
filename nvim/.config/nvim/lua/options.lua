require "nvchad.options"

-- CursorLine showing
-- vim.o.cursorlineopt = "both"

-- Recommended session options from auto-sessions
vim.opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

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
-- vim.g.clipboard = {
--   name = "wsl-clipboard",
--   copy = {
--     ["+"] = "clip.exe",
--     ["*"] = "clip.exe",
--   },
--   -- Esta parte se sobreescribe con el autocmd TextYankPost
--   paste = {
--     ["+"] = [[powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write((Get-Clipboard -Raw).ToString().Replace("`r",""))]],
--     ["*"] = [[powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write((Get-Clipboard -Raw).ToString().Replace("`r",""))]],
--   },
--   cache_enabled = 0,
-- }

-- "" = Neovim usa su propio registro interno 
-- Aquí lo dejamos vacío para que `p` pegue siempre de Neovim, no del sistema
vim.opt.clipboard = ""

