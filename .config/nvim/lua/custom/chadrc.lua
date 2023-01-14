-- Just an example, supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.ui = {
  theme = "snazzy",
}

M.plugins = {
  user = {
    ["windwp/nvim-ts-autotag"] = {
      ft = { "html", "javascriptreact" },
      after = "nvim-treesitter",
      config = function ()
        require("nvim-ts-autotag").setup()
      end
    },
    ["jose-elias-alvarez/null-ls.nvim"] = {
      after = "nvim-lspconfig",
      config = function()
        require "custom.plugins.null-ls"
      end
    },
    ["neovim/nvim-lspconfig"] = {
      config = function()
        require "plugins.configs.lspconfig"
        require "custom.plugins.lspconfig"
      end,
    },
  },
  override = {
    ["nvim-treesitter/nvim-treesitter"] = {
      ensure_installed = {
        "astro",
        "bash",
        "css",
        "dockerfile",
        "graphql",
        "html",
        "http",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "json5",
        "lua",
        "make",
        "markdown",
        "prisma",
        "proto",
        "python",
        "regex",
        "rust",
        "scss",
        "sql",
        "svelte",
        "toml",
        "tsx",
        "typescript",
        "vue",
        "yaml",
        "sxhkdrc",
      },
    },
    ["williamboman/mason.nvim"] = {
      ensure_installed = {
        -- LSPs
        "astro-language-server",
        "bash-language-server",
        "css-lsp", -- css, scss
        "cssmodules-language-server",
        "dockerfile-language-server",
        "graphql-language-service-cli",
        "html-lsp",
        "jdtls", -- java
        "json-lsp",
        "lua-language-server",
        "prisma-language-server",
        "eslint-lsp",
        "typescript-language-server",
        "marksman", -- markdown
        "pyright", -- python
        "rust-analyzer",
        "sqlls", -- sql
        "svelte-language-server",
        "taplo", -- toml
        "vue-language-server",
        "yaml-language-server",

       -- Linters & Formatters
        "shellharden", -- bash
        "prettierd", -- javascript, typescript, css, sccs
        "eslint_d", -- javascript, typescript
        "xo", -- javascript, typescript
        "selene", -- lua
        "stylua", -- lua
        "mypy", -- python
        "pylint", -- python
        "actionlint", -- yaml
      },
    },
  },
}

return M
