-- ~/.config/nvim/lua/configs/lspconfig.lua
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- Инициализируем lspconfig чтобы добавить его конфиги в runtime path
require "lspconfig"

-- Список серверов для включения
local servers = {
  "lua_ls",
  "pyright",
  "bashls",
  "yamlls",
  "dockerls",
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

-- Включаем все серверы
vim.lsp.enable(servers)

-- === DIAGNOSTIC CONFIGURATION ===
vim.diagnostic.config {
  virtual_text = {
    prefix = "●",
    source = "if_many",
    spacing = 4,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    source = "always",
    border = "rounded",
    focusable = true,
  },
}

-- Настройка иконок для ошибок
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = "󰋽 " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
