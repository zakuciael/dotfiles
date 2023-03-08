local opt = vim.opt
local g = vim.g

vim.o.termguicolors = true

g.mapleader = ' '
g.maplocalleader = ' '

opt.clipboard = "unnamedplus"
opt.cursorline = true
opt.backspace = '2'
opt.showcmd = true
opt.laststatus = 3
opt.autowrite = true
opt.autoread = true
opt.showmode = false

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

-- Numbers
opt.number = true
-- opt.relativenumber = true
opt.numberwidth = 2
opt.ruler = false

-- Disable nvim intro
opt.shortmess:append "sI"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

-- Interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250


-- Setup lsp options

local function lsp_symbol(name, icon)
  local highlight = "DiagnosticSign" .. name
  vim.fn.sign_define(highlight, { text = icon, numhl = highlight, texthl = highlight })
end

lsp_symbol("Error", "")
lsp_symbol("Info", "")
lsp_symbol("Hint", "")
lsp_symbol("Warn", "")

vim.diagnostic.config({
  virtual_text = {
    prefix = "",
  },
  signs = true,
  underline = true,
  update_in_insert = true,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = "single" }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = "single", focusable = false, relative = "cursor" }
)

vim.notify = function(msg, level)
  if msg:match("exit code") then
    return
  end

  if level == vim.log.levels.ERROR then
    vim.api.nvim_err_writeln(msg)
  else
    vim.api.nvim_echo({ { msg } }, true, {})
  end
end

-- Disable some builtin vim plugins
local default_plugins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "syntax",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}

for _, plugin in pairs(default_plugins) do
  g["loaded_" .. plugin] = 1
end

local default_providers = {
  "node",
  "perl",
  "python3",
  "ruby",
}

for _, provider in ipairs(default_providers) do
  g["loaded_" .. provider .. "_provider"] = 0
end
