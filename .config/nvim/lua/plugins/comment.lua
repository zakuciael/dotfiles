return {
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    keys = {
      {
        "<leader>/",
        "<Plug>(comment_toggle_linewise_current)",
        mode = "n",
        desc = "Toggle comment linewise"
      },
      {
        "<leader>/",
        "<Plug>(comment_toggle_blockwise_visual)",
        mode = "v",
        desc = "Toggle comment blockwise"
      },
      {
        "gcc",
        nil,
        mode = "n"
      },
      {
        "gbc",
        nil,
        mode = "n"
      }
    },
    config = function(opts)
      local plugin_opts = vim.tbl_deep_extend(
        "force",
        { pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook() },
        opts
      )

      require("Comment").setup(plugin_opts)
    end,
    opts = {
      toggler = {
        ---Line-comment toggle keymap
        line = 'gcc',
        ---Block-comment toggle keymap
        block = 'gbc',
      },
      mappings = {
        basic = true,
        extra = false
      }
    }
  }
}
