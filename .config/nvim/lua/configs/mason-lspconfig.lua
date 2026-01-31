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
    "gitlab_ci_ls",
    "helm_ls",
    "jinja_lsp",
    "docker_compose_language_service",
  },
  automatic_installation = false,
}
