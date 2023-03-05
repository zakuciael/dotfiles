local lazy_load = require("core.lazy_load")

return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = lazy_load.on_file_open,
    opts = {
      indentLine_enabled = 1,
      filetype_exclude = {
        "help",
        "terminal",
        "alpha",
        "packer",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
        "mason",
        "",
      },
      buftype_exclude = { "terminal" },
      show_trailing_blankline_indent = false,
      show_first_indent_level = false,
      show_current_context = true,
      show_current_context_start = true,
    }
  },
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
  },
  {
    "numToStr/Comment.nvim",
    init = function()
      -- TODO: mappings
    end
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    keys = {
      { "<C-n>", ":NvimTreeToggle<CR>", mode = "n", desc = "Toggle file tree" },
      { "<leader>e", ":NvimTreeFocus<CR>", mode = "n", desc = "Focus file tree" }
    },
    config = function(_, opts)
      vim.g.nvimtree_side = opts.view.side
      require("nvim-tree").setup(opts)
    end,
    opts = {
      filters = {
        dotfiles = false,
        -- exclude = { vim.fn.stdpath("config") .. "/lua/custom" }
      },
      disable_netrw = true,
      hijack_netrw = true,
      hijack_cursor = true,
      hijack_unnamed_buffer_when_opening = false,
      update_cwd = true,
      update_focused_file = {
        enable = true,
        update_cwd = false
      },
      view = {
        adaptive_size = true,
        side = "left",
        width = 25,
        hide_root_folder = true
      },
      git = {
        enable = false,
        ignore = true
      },
      filesystem_watchers = {
        enable = true
      },
      actions = {
        open_file = {
          resize_window = true
        }
      },
      renderer = {
        highlight_git = false,
        highlight_opened_files = "none",
        indent_markers = {
          enable = false
        },
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = false
          },
          glyphs = {
            default = "",
            symlink = "",
            folder = {
              default = "",
              empty = "",
              empty_open = "",
              open = "",
              symlink = "",
              symlink_open = "",
              arrow_open = "",
              arrow_closed = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          }
        }
      }
    }
  }
}
