require("core.options")
-- Setup lazy.nvim and plugins

local install_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(install_path) then
  print("Installing lazy.nvim")

  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    install_path,
  })

  print("lazy.nvim installed successfully")
end

vim.opt.rtp:prepend(install_path)

require("lazy").setup("plugins")
