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
        function()
          -- https://github.com/numToStr/Comment.nvim/blob/6821b3ae27a57f1f3cf8ed030e4a55d70d0c4e43/lua/Comment/init.lua#L103
          return vim.api.nvim_get_vvar('count') == 0 and '<Plug>(comment_toggle_linewise_current)'
                    or '<Plug>(comment_toggle_linewise_count)'
        end,
        mode = "n"
      },
      {
        "gbc",
        function()
          -- https://github.com/numToStr/Comment.nvim/blob/6821b3ae27a57f1f3cf8ed030e4a55d70d0c4e43/lua/Comment/init.lua#L107
          return vim.api.nvim_get_vvar('count') == 0 and '<Plug>(comment_toggle_blockwise_current)'
                    or '<Plug>(comment_toggle_blockwise_count)'
        end,
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
