local M = {}

M.on_file_open = { "BufRead", "BufWinEnter", "BufNewFile" }

M.treesitter_cmds = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" }
M.mason_cmds = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" }



return M
