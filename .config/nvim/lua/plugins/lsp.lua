local load_mappings = require("core.utils").load_mappings
local lazy_load = require("core.lazy_load")

local mason_ensure_installed = {
  "lua-language-server",
  "eslint-lsp",
  "prettier",
  "typescript-language-server",
  "bash-language-server"
}

-- Setup lsp capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

-- Setup lsp keymaps
local keymaps = {
  -- Normal mode
  n = {
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "Show declaration"
    },
    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "Show definition"
    },
    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "Show hover"
    },
    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "Show implementation"
    },
    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "Signature help"
    },
    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "Show definition type",
    },
    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "Execute code action",
    },
    ["gr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "Show references",
    },
    ["<leader>f"] = {
      function()
        vim.diagnostic.open_float()
      end,
      "Show floating diagnostic",
    },
    ["[d"] = {
      function()
        vim.diagnostic.goto_prev()
      end,
      "Goto prev error",
    },
    ["]d"] = {
      function()
        vim.diagnostic.goto_next()
      end,
      "Goto next error",
    },
    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "Format file",
    },
  }
}

local function on_attach(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  load_mappings(keymaps, { buffer = bufnr })
end


return {
    {
    "williamboman/mason.nvim",
    event = lazy_load.on_file_open,
    cmd = lazy_load.mason_cmds,
    build = ":MasonInstallAll",
    config = function(opts)
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(mason_ensure_installed, " "))
      end, {})

      require("mason").setup(opts)
    end,
    opts = {
      PATH = "skip",
      ui = {
        icons = {
          package_pending = " ",
          package_installed = " ",
          package_uninstalled = " ﮊ",
        },
        keymaps = {
          toggle_server_expand = "<CR>",
          install_server = "i",
          update_server = "u",
          check_server_version = "c",
          update_all_servers = "U",
          check_outdated_servers = "C",
          uninstall_server = "X",
          cancel_installation = "<C-c>",
        },
      },
      max_concurrent_installers = 10,
    }
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = lazy_load.on_file_open,
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")

      mason_lspconfig.setup()
      mason_lspconfig.setup_handlers({
        function(server)
          lspconfig[server].setup({
            on_attach = on_attach,
            capabilities = capabilities,
          })
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" }
                },
                workspace = {
                  library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                    [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true
                  },
                  maxPreload = 100000,
                  preloadFileSize = 10000
                }
              }
            }
          })
        end
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    event = lazy_load.on_file_open,
    config = function()
      require("lspconfig.ui.windows").default_options.border = "single"
    end
  },
  {
    "simrat39/rust-tools.nvim",
    config = function()
      require("rust-tools").setup()
    end
  },
}
