-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- Language Servers (LSP)

        -- Frontend
        "typescript-language-server", -- TypeScript/JavaScript
        "html-lsp", -- HTML
        "css-lsp", -- CSS/SCSS/LESS
        "tailwindcss-language-server", -- Tailwind CSS
        "emmet-ls", -- Emmet
        "eslint-lsp", -- ESLint
        "prisma-language-server", -- Prisma ORM
        "svelte-language-server", -- Svelte
        "vue-language-server", -- Vue.js
        "astro-language-server", -- Astro

        -- Backend
        "lua-language-server", -- Lua
        "pyright", -- Python
        "gopls", -- Go
        "rust-analyzer", -- Rust
        "jdtls", -- Java

        -- Database & Data
        "sqlls", -- SQL
        "graphql-language-service-cli", -- GraphQL

        -- DevOps & Config
        "dockerfile-language-server", -- Docker
        "docker-compose-language-service", -- Docker Compose
        "yaml-language-server", -- YAML
        "terraform-ls", -- Terraform
        "ansible-language-server", -- Ansible
        "helm-ls", -- Helm

        -- Markup & Docs
        "marksman", -- Markdown
        "json-lsp", -- JSON

        -- Shell
        "bash-language-server", -- Bash

        -- Formatters
        "stylua", -- Lua formatter
        "prettier", -- JS/TS/CSS/HTML/JSON/YAML formatter
        "prettierd", -- Faster prettier
        "black", -- Python formatter
        "gofumpt", -- Go formatter
        "shfmt", -- Shell formatter
        "yamlfmt", -- YAML formatter

        -- Linters
        "eslint_d", -- Fast ESLint
        "flake8", -- Python linter
        "golangci-lint", -- Go linter
        "shellcheck", -- Shell script linter
        "hadolint", -- Dockerfile linter

        -- Debuggers
        "debugpy", -- Python debugger
        "delve", -- Go debugger
        "codelldb", -- Rust/C/C++ debugger

        -- Tools
        "tree-sitter-cli", -- Tree-sitter CLI
      },
    },
  },
}
