-- ~/.config/nvim/lua/configs/mason-lspconfig.lua

require("mason-lspconfig").setup {
  ensure_installed = {
    "lua_ls",
    "pyright",
    "bashls",
    "yamlls",
    "dockerls",
    "gopls",
    "ansiblels",
    "nginx_language_server",
  },
  automatic_installation = false,
}
