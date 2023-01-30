local present, mason_lspconfig = pcall(require, "mason-lspconfig")

if not present then
  return
end

mason_lspconfig.setup({
  ensure_installed = {
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
  },
})
