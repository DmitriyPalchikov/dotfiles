local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
local cache_dir = vim.uv.os_homedir() .. '/.cache/gitlab-ci-ls/'
local util = require("lspconfig.util")
-- Инициализируем lspconfig чтобы добавить его конфиги в runtime path
require "lspconfig"

-- Список серверов для включения
local servers = {
  "lua_ls",
  "pyright",
  "bashls",
  "yamlls",
  "dockerls",
  "gopls",
  "ansiblels",
  "nginx_language_server",
  "gitlab_ci_ls",
  "helm_ls",
  "jinja_lsp",
  "docker_compose_language_service",
}

-- Настраиваем глобальные параметры для всех LSP серверов
vim.lsp.config("*", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
})

-- Кастомизируем lua_ls
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        enable = false,
      },
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
          vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
          "${3rd}/love2d/library",
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})

-- Кастомизируем bashls
vim.lsp.config("bashls", {
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "zsh", "bash" },
  settings = {
    bash = {
      diagnostics = {
        enable = true,
      },
    },
  },
})

vim.lsp.config("jinja_lsp", {
  name = "jinja_lsp",
  cmd = { "jinja-lsp" },
  filetypes = { "jinja" },
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.j2",
  callback = function()
    vim.bo.filetype = "jinja"
  end,
})

vim.lsp.config("docker_compose_language_service", {
  cmd = { 'docker-compose-langserver', '--stdio' },
  filetypes = { 'yaml.docker-compose' },
  root_markers = { 'docker-compose.yaml', 'docker-compose.yml', 'compose.yaml', 'compose.yml' },
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.compose*.yml", "*.compose*.yaml", "docker-compose*.yml", "docker-compose*.yaml" },
  callback = function()
    vim.bo.filetype = "yaml.docker-compose"
  end,
  desc = "Set filetype for Docker Compose files",
})

vim.lsp.config("gopls", { -- nvim 0.11
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    on_attach(client, bufnr)
  end,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gotmpl", "gowork" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      completeUnimported = true,
      usePlaceholders = true,
      staticcheck = true,
    },
  },
})

vim.lsp.config("ansiblels", {
  cmd = { "ansible-language-server", "--stdio" },
  filetypes = { "yaml.ansible", "ansible" },
  settings = {
    ansible = {
      validation = {
        enabled = true,
        lint = {
          enabled = true,
          path = "ansible-lint",
        },
      },
    },
  },
})


vim.lsp.config("gitlab_ci_ls", {
  cmd = { "gitlab-ci-ls" },
  filetypes = { "yaml.gitlab" },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(util.root_pattern('.git', '.gitlab*')(fname))
  end,
  init_options = {
    cache_path = cache_dir,
    log_path = cache_dir .. '/log/gitlab-ci-ls.log',
  },
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.gitlab-ci*.{yml,yaml}",
  callback = function()
    vim.bo.filetype = "yaml.gitlab"
  end,
})


-- Включаем все серверы
vim.lsp.enable(servers)

-- === DIAGNOSTIC CONFIGURATION ===
vim.diagnostic.config {
  virtual_text = {
    prefix = "●",
    source = "if_many",
    spacing = 4,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    source = "always",
    border = "rounded",
    focusable = true,
  },
}
