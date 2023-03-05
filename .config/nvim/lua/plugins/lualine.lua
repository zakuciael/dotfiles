local function diff_source()
  if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
    return nil
  end

  local git_status = vim.b.gitsigns_status_dict

  return {
    added = git_status.added,
    modified = git_status.changed,
    removed = git_status.removed
  }
end

return {
  "arkav/lualine-lsp-progress",
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = true,
        section_separators = { left = '', right = "" },
        theme = "base16"
      },
      sections = {
        -- left side
        lualine_a = { { "mode", icon = "" } },
        lualine_b = {
          { "filetype", colored = false, icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", separator = "", padding = 1, symbols = { unnamed = " Empty" } }
        },
        lualine_c = {
          { "branch", icon = " ", separator = "", padding = { left = 1, right = 0 } },
          { "diff", source = diff_source, colored = false, symbols = { added = " ", modified = " ", removed = " " }, padding = 1 },
          -- TODO: Setup lsp progress
          --[[ "%=",
          { "lsp_progress" },
          "=%" ]]--
        },

        -- right side
        -- lualine_x = { lsp_diagnostics, lsp_status },
        -- lualine_y = { cwd },
        lualine_z = { { "progress", icon = "" } },
      }
    }
  }
}
