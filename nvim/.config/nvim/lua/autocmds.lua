require "nvchad.autocmds"


-- Sincronizar yank/delete con el portapapeles de Windows
-- Se ejecuta cada vez que haces yank o delete
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    if vim.v.event.regname == "_" then return end -- ignora black-hole
    vim.fn.setreg("+", vim.v.event.regcontents, vim.v.event.regtype)
  end,
})

-- Jump to last position when reopening a file
vim.api.nvim_create_autocmd('BufReadPost', {
    desc = 'Open file at the last position it was edited earlier',
    command = 'silent! normal! g`"zv',
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

-- Show Nvdash when all buffers are closed
vim.api.nvim_create_autocmd("BufDelete", {
  callback = function()
    local bufs = vim.t.bufs
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
      vim.cmd "Nvdash"
    end
  end,
})

-- Asegura que foldlevel sea 99 
vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    vim.opt_local.foldlevel = 99
    vim.opt_local.foldlevelstart = 99
  end,
})

local grp = vim.api.nvim_create_augroup("remember_folds_ufo", { clear = true })

-- Guardar folds al salir de la ventana del buffer
vim.api.nvim_create_autocmd("BufWinLeave", {
  group = grp,
  callback = function()
    pcall(vim.cmd, "mkview")
  end,
})

-- Restaurar folds al entrar (con pequeño delay para que ufo/treesitter no lo pisen)
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = grp,
  callback = function()
    vim.schedule(function()
      pcall(vim.cmd, "silent! loadview")
    end)
  end,
})
