local present, mason_lspconfig = pcall(require, "mason-lspconfig")
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require("lspconfig")

if not present then
  return
end

mason_lspconfig.setup()

mason_lspconfig.setup_handlers {
  function (server_name)
    -- vim.notify(server_name, vim.log.levels.INFO)

    if server_name == "lua_ls" then
      return
    end

    lspconfig[server_name].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
}
