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

local function cwd()
  local dir_icon = "%#lualine_cwd_icon#" .. " "
  local dir_name = "%#lualine_cwd_text#" .. " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

  return (vim.o.columns > 85 and (dir_icon .. dir_name)) or ""
end

local function progress()
  local icon = "%#lualine_progress_icon#" .. " "

  local current_line = vim.fn.line(".")
  local total_line = vim.fn.line("$")

  local text = math.modf((current_line / total_line) * 100) .. tostring("%%")
  text = (current_line == 1 and "Top") or text
  text = (current_line == total_line and "Bot") or text

  return icon .. "%#lualine_progress_text# " .. text
end

local function lsp_progress()
  if not rawget(vim, "lsp") then
    return ""
  end

  local lsp = vim.lsp.util.get_progress_messages()[1]

  if vim.o.columns < 120 or not lsp then
    return ""
  end

  local msg = lsp.message or ""
  local proc = lsp.percentage or 0
  local title = lsp.title or ""
  local spinners = { "", "" }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners

  local content = string.format(
    " %%<%s %s %s (%s%%%%)",
    spinners[frame + 1],
    title,
    msg,
    proc
  )

  return ("%#lualine_lsp_progress#" .. content) or ""
end

local function lsp_status()
  if not rawget(vim, "lsp") then
    return ""
  end

  for _, client in ipairs(vim.lsp.get_active_clients()) do
    if not client.attached_buffers[vim.api.nvim_get_current_buf()] then
      return ""
    end

    return (vim.o.columns > 100 and "%#lualine_lsp_status#" .. "  LSP ~ " .. client.name) or ("%#lualine_lsp_status#" .. "  LSP")
  end

  return ""
end

return {
  "arkav/lualine-lsp-progress",
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = true,
        section_separators = { left = "", right = "" },
        theme = "base16"
      },
      sections = {
        -- left side
        lualine_a = { { "mode", icon = "" } },
        lualine_b = {
          {
            "filetype",
            colored = false,
            icon_only = true,
            separator = "",
            padding = { left = 1, right = 0 }
          },
          {
            "filename",
            separator = "",
            padding = 1,
            symbols = { unnamed = " Empty" }
          }
        },
        lualine_c = {
          {
            "branch",
            icon = " ",
            separator = "",
            padding = { left = 1, right = 0 }
          },
          {
            "diff",
            source = diff_source,
            separator = "",
            colored = false,
            symbols = { added = " ", modified = " ", removed = " " },
            padding = 1
          },
          { "%=", separator = "" },
          { lsp_progress },
          { "=%", separator = "" }
        },

        -- right side
        lualine_x = {
          {
            "diagnostics",
            separator = "",
            sources = { "nvim_diagnostic", "nvim_lsp", "vim_lsp" },
            sections = { "error", "warn", "info", "hint" },
            symbols = { error = " ", warn = " ", info = " ", hint = "ﯧ " },
            diagnostics_color = {
              error = "lualine_lsp_diagnostic_error",
              warn = "lualine_lsp_diagnostic_warn",
              info = "lualine_lsp_diagnostic_info",
              hint = "lualine_lsp_diagnostic_hint"
            },
            colored = true,
            update_in_insert = true,
          },
          { lsp_status }
        },
        lualine_y = { { cwd, padding = { left = 0, right = 1 } } },
        lualine_z = { { progress, padding = { left = 0, right = 1 } } }
      }
    }
  }
}
