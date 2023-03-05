local lazy_load = require("core.lazy_load")

local mason_ensure_installed = { "lua-language-server" }

local capabilities = vim.lsp.protocol.make_client_capabilities()
local on_attach = function(client, bufnr)

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
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
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
  { "neovim/nvim-lspconfig", event = lazy_load.on_file_open }
}
