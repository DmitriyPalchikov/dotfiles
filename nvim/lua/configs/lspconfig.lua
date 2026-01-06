-- ~/.config/nvim/lua/configs/lspconfig.lua
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
local util = require "lspconfig.util"

-- Новый API - замените require("lspconfig").setup()
-- require("lspconfig").setup()  -- УДАЛИТЕ ЭТУ СТРОКУ

-- Список серверов
local servers = {
  "lua_ls",
  "pyright",
  "bashls",
  "yamlls",
  "dockerls",
}

-- Настройка серверов с дефолтной конфигурацией
local default_servers = { "pyright", "yamlls", "dockerls" }
for _, lsp in ipairs(default_servers) do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })
end

-- lua_ls с кастомными настройками
vim.lsp.config("lua_ls", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
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

-- bashls с кастомными настройками
vim.lsp.config("bashls", {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "zsh", "bash" },
  root_dir = util.root_pattern(".git", vim.fn.getcwd()),
  settings = {
    bash = {
      diagnostics = {
        enable = true,
      },
    },
  },
})

-- Активируем все LSP серверы (добавьте это в init.lua или после конфигурации)
vim.lsp.enable(servers)
