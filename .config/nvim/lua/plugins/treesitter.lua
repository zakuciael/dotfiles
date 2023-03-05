local lazy_load = require("core.lazy_load")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = lazy_load.on_file_open,
    cmd = lazy_load.treesitter_cmds,
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "lua",
      },
      highlight = {
        enable = true,
        use_languagetree = true,
      },
      indent = {
        enable = true,
      },
    }
  }
}
