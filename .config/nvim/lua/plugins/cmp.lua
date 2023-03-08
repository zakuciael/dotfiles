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
    opts = {
      completion = {
        completeopt = "menu,menuone",
      },
      window = {
        completion = {
          side_padding = 0,
          border = border("CmpBorder"),
          -- winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
          scrollbar = false
        },
        documentation = {
          border = border("CmpDocBorder"),
          -- winhighlight = "Normal:CmpDoc",
        },
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end
      },
      formatting = {
        format = function(_, item)
          item.kind = string.format("%s %s", lspkind_icons[item.kind], item.kind)
          return item
        end
      },
      mapping = require("cmp").mapping.preset.insert({
        ["<C-p>"] = require("cmp").mapping.select_prev_item(),
        ["<C-n>"] = require("cmp").mapping.select_next_item(),
        ["<C-d>"] = require("cmp").mapping.scroll_docs(-4),
        ["<C-f>"] = require("cmp").mapping.scroll_docs(),
        ["<C-Space>"] = require("cmp").mapping.complete(),
        ["<C-e>"] = require("cmp").mapping.close(),
        ["<CR>"] = require("cmp").mapping.confirm({
          behavior = require("cmp").ConfirmBehavior.Replace,
          select = false
        }),
        ["<Tab>"] = require("cmp").mapping(function(fallback)
          local cmp = require("cmp")

          if cmp.visible() then
            cmp.select_next_item()
          elseif require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(
              vim.api.nvim_replace_termcodes(
                "<Plug>luasnip-expand-or-jump",
                true,
                true,
                true
              ),
              ""
            )
          else
            fallback()
          end
        end),
        ["<S-Tab>"] = require("cmp").mapping(function(fallback)
          local cmp = require("cmp")

          if cmp.visible() then
            cmp.select_prev_item()
          elseif require("luasnip").jumpable(-1) then
            vim.fn.feedkeys(
              vim.api.nvim_replace_termcodes(
                "<Plug>luasnip-jump-prev",
                true,
                true,
                true
              ),
              ""
            )
          else
            fallback()
          end
        end)
      }),
      sources = {
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = 'nvim_lsp_signature_help' }
      },
    }
  },
  {
    "L3MON4D3/LuaSnip",
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
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-nvim-lsp-signature-help"
}
