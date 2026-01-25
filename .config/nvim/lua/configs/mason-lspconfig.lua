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
  },
  automatic_installation = false,
}
