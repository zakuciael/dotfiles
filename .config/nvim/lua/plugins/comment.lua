return {
  {
    "numToStr/Comment.nvim",
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
      }
    }
  }
}
