local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
local lspconfig = require("lspconfig")

local servers = {
	"lua_ls",
	"pyright",
	"bashls",
	"yamlls",
	"dockerls",
}

local default_servers = { "pyright" }

-- Используем старый API, который работает везде
for _, server in ipairs(default_servers) do
	lspconfig[server].setup({
		on_attach = on_attach,
		on_init = on_init,
		capabilities = capabilities,
	})
end

lspconfig.lua_ls.setup({
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
					vim.fn.expand("$VIMRUNTIME/lua"),
					vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
					vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
					vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
					"${3rd}/love2d/library",
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
		},
	},
})

lspconfig.bashls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
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

-- === DIAGNOSTIC CONFIGURATION ===
vim.diagnostic.config({
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
})

-- Настройка иконок для ошибок
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = "󰋽 " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
