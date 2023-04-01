local lazy_load = require("core.lazy_load")

return {
  {
    "wakatime/vim-wakatime",
    event = lazy_load.on_file_open
  }
}
