local lspkind_icons = {
  Namespace = "",
  Text = " ",
  Method = " ",
  Function = " ",
  Constructor = " ",
  Field = "ﰠ ",
  Variable = " ",
  Class = "ﴯ ",
  Interface = " ",
  Module = " ",
  Property = "ﰠ ",
  Unit = "塞 ",
  Value = " ",
  Enum = " ",
  Keyword = " ",
  Snippet = " ",
  Color = " ",
  File = " ",
  Reference = " ",
  Folder = " ",
  EnumMember = " ",
  Constant = " ",
  Struct = "פּ ",
  Event = " ",
  Operator = " ",
  TypeParameter = " ",
  Table = "",
  Object = " ",
  Tag = "",
  Array = "[]",
  Boolean = " ",
  Number = " ",
  Null = "ﳠ",
  String = " ",
  Calendar = "",
  Watch = " ",
  Package = "",
  Copilot = " ",
}

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

return {
  { "rafamadriz/friendly-snippets", event = { "InsertEnter" } },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      window = {
        completion = {
          border = border("CmpBorder"),
          winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
        },
        documentation = {
          border = border("CmpDocBorder"),
        },
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end
      },
      formatting = {
        format = function(_, vim_item)
          vim_item.kind = string.format("%s %s", lspkind_icons[vim_item.kind], vim_item.kind)
          return vim_item
        end
      },
      mapping = {
        -- TODO: mapping
      },
      sources = {
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
      }
    }
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets", "hrsh7th/nvim-cmp" },
    config = function(_, opts)
      local luasnip = require("luasnip")
      local luasnip_vscode_loader = require("luasnip.loaders.from_vscode")

      luasnip.config.set_config(opts)
      luasnip_vscode_loader.lazy_load({ paths = vim.g.luasnippets_path or "" })
      luasnip_vscode_loader.lazy_load()

      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          local luasnip = require("luasnip")

          if
            luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
            and not luasnip.session.jump_active
          then
            luasnip.unlink_current()
          end
        end
      })
    end,
    opts = {
      history = true,
      updateevents = "TextChanged,TextChangedI",
    }
  },
  { "saadparwaiz1/cmp_luasnip", dependencies = { "L3MON4D3/LuaSnip" } },
  { "hrsh7th/cmp-nvim-lua", dependencies = { "saadparwaiz1/cmp_luasnip" } },
  { "hrsh7th/cmp-nvim-lsp", dependencies = { "hrsh7th/cmp-nvim-lua" } },
  { "hrsh7th/cmp-buffer", dependencies = { "hrsh7th/cmp-nvim-lsp" } },
  { "hrsh7th/cmp-path", dependencies = { "hrsh7th/cmp-buffer" } }
}
