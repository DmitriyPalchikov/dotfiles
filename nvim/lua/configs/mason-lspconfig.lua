-- ~/.config/nvim/lua/configs/mason-lspconfig.lua

require("mason-lspconfig").setup {
  ensure_installed = {
    "lua_ls",
    "pyright",
    "bashls",
    "yamlls",
    "dockerls",
  },
  automatic_installation = false,
}
