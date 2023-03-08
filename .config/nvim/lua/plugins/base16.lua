return {
  {
    "RRethy/nvim-base16",
    config = function(colors)
      local colors = {
        base00 = '#242424', -- '#282a36'
        base01 = '#34353e',
        base02 = '#43454f',
        base03 = '#78787e',
        base04 = '#a5a5a9',
        base05 = '#e2e4e5',
        base06  = '#eff0eb',
        base07  = '#f1f1f0',
        base08 = '#ff5c57',
        base09 = '#ff9f43',
        base0A = '#f3f99d',
        base0B = '#5af78e',
        base0C = '#9aedfe',
        base0D = '#57c7ff',
        base0E = '#ff6ac1',
        base0F = '#b2643c',
      }

      require("base16-colorscheme").setup(colors, { notify = false })

      -- Lualine highlights

      -- LSP status component
      vim.api.nvim_set_hl(0, "lualine_lsp_status", { fg = colors.base0D, bg = colors.base01 })

      -- LSP progress component
      vim.api.nvim_set_hl(0, "lualine_lsp_progress", { fg = colors.base0B, bg = colors.base01 })

      -- LSP diagnostic component
      vim.api.nvim_set_hl(0, "lualine_lsp_diagnostic_error", { fg = colors.base08, bg = colors.base01 })
      vim.api.nvim_set_hl(0, "lualine_lsp_diagnostic_warn", { fg = colors.base0A, bg = colors.base01 })
      vim.api.nvim_set_hl(0, "lualine_lsp_diagnostic_info", { fg = colors.base0B, bg = colors.base01 })
      vim.api.nvim_set_hl(0, "lualine_lsp_diagnostic_hint", { fg = colors.base0E, bg = colors.base01 })

      -- CWD component
      vim.api.nvim_set_hl(0, "lualine_cwd_icon", { fg = colors.base00, bg = colors.base08 })
      vim.api.nvim_set_hl(0, "lualine_cwd_text", { fg = colors.base07, bg = colors.base02 })

      -- Progress component
      vim.api.nvim_set_hl(0, "lualine_progress_icon", { fg = colors.base00, bg = colors.base0B })
      vim.api.nvim_set_hl(0, "lualine_progress_text", { fg = colors.base0B, bg = colors.base02 })
    end
  }
}
