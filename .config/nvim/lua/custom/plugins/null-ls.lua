local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local b = null_ls.builtins

local sources = {
  -- Formatters
  b.formatting.prettierd,
  b.formatting.stylua,

  -- Linters
  b.diagnostics.eslint_d,
  b.diagnostics.actionlint,
  b.diagnostics.selene,
  b.diagnostics.mypy,
  b.diagnostics.pylint,

  -- Code actions
  b.code_actions.eslint_d,
}

null_ls.setup {
  debug = true,
  sources = sources,
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.formatting_sync()
        end,
      })
    end
  end,
}
