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

      local lsp = {
        error = colors.base08,
        warn = colors.base0A,
        info = colors.base0B,
        hint = colors.base0C
      }

      local background = colors.base00
      local lualine_bg = colors.base01
      local lualine_accent = colors.base02

      -- LSP diagnostics highlights
      vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = lsp.error, bg = background })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = lsp.error, bg = background })

      vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = lsp.warn, bg = background })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = lsp.warn, bg = background })

      vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = lsp.info, bg = background })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = lsp.info, bg = background })

      vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = lsp.hint, bg = background })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = lsp.hint, bg = background })

      -- Lualine highlights

      -- LSP status component
      vim.api.nvim_set_hl(0, "lualine_lsp_status", { fg = colors.base0D, bg = lualine_bg })

      -- LSP progress component
      vim.api.nvim_set_hl(0, "lualine_lsp_progress", { fg = colors.base0B, bg = lualine_bg })

      -- LSP diagnostic component
      vim.api.nvim_set_hl(0, "lualine_lsp_diagnostic_error", { fg = lsp.error, bg = lualine_bg })
      vim.api.nvim_set_hl(0, "lualine_lsp_diagnostic_warn", { fg = lsp.warn, bg = lualine_bg })
      vim.api.nvim_set_hl(0, "lualine_lsp_diagnostic_info", { fg = lsp.info, bg = lualine_bg })
      vim.api.nvim_set_hl(0, "lualine_lsp_diagnostic_hint", { fg = lsp.hint, bg = lualine_bg })

      -- CWD component
      vim.api.nvim_set_hl(0, "lualine_cwd_icon", { fg = background, bg = colors.base08 })
      vim.api.nvim_set_hl(0, "lualine_cwd_text", { fg = colors.base07, bg = lualine_accent })

      -- Progress component
      vim.api.nvim_set_hl(0, "lualine_progress_icon", { fg = background, bg = colors.base0B })
      vim.api.nvim_set_hl(0, "lualine_progress_text", { fg = colors.base0B, bg = lualine_accent })
    end
  }
}
