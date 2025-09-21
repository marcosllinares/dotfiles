require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "pyright", "clangd", "lua_ls" }
vim.lsp.enable(servers)

-- ========== Diagnostics base ==========
vim.diagnostic.config({
  vitual_lines = true,
  virtual_text = { prefix = "●", spacing = 2 },   -- texto inline
  signs = true,                                    -- signos en el gutter
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN]  = " ",
      [vim.diagnostic.severity.INFO]  = " ",
      [vim.diagnostic.severity.HINT]  = "󰌶 ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN]  = "WarningMsg",
    },
  },
})

-- Iconos del gutter
-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
-- local signs = { Error = " ", Warn = " ", Info = " ", Hint = "󰌶 " }
-- for type, icon in pairs(signs) do
--   local hl = "DiagnosticSign" .. type
--   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
-- end

-- read :h vim.lsp.config for changing options of lsp servers 
