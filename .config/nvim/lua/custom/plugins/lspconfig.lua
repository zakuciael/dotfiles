local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local servers = {
  "astro",
  "cssls",
  "cssmodules_ls",
  "dockerls",
  "graphql",
  "html",
  "jdtls",
  "sumneko_lua",
  "jsonls",
  "prismals",
  "eslint",
  "tsserver",
  "marksman",
  "pyright",
  "rust_analyzer",
  "sqlls",
  "svelte",
  "taplo",
  "volar",
  "yamlls",
  "gopls"
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    -- root_dir = function()
    --   return vim.loop.cwd()
    -- end,
  }
end
