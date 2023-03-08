return {
  {
    "windwp/nvim-autopairs",
    dependencies = { "hrsh7th/nvim-cmp" },
    opts = {
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" }
    },
    config = function(_, opts)
      local autopairs = require("nvim-autopairs")
      local cmp = require("cmp")
      autopairs.setup(opts)

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
  }
}
