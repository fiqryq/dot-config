---@type LazySpec
return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "tailwindcss",
        "html",
        "cssls",
        "svelte",
        "volar",
        "angularls",
        "astro",
        "emmet_ls",
        "eslint",
        "pyright",
        "ruff",
        "rust_analyzer",
        "gopls",
        "jdtls",
        "clangd",
        "omnisharp",
        "phpactor",
        "jsonls",
        "yamlls",
        "taplo",
        "bashls",
        "dockerls",
        "docker_compose_language_service",
        "prismals",
        "sqls",
        "graphql",
        "marksman",
      },
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      ensure_installed = {
        "stylua",
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = {
        "python",
      },
    },
  },
}
