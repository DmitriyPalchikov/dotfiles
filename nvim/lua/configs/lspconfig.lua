local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
local util = require("lspconfig.util")
local lspconfig = require("lspconfig")

-- list of all servers configured.
lspconfig.servers = {
	"lua_ls",
	"pyright",
	"bashls",
	"yamlls",
	"dockerls",
}

-- list of servers configured with default config.
local default_servers = { "pyright" }

-- lsps with default config
for _, lsp in ipairs(default_servers) do
	lspconfig[lsp].setup({
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
				enable = false, -- Disable all diagnostics from lua_ls
				-- globals = { "vim" },
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
	root_dir = util.root_pattern(".git", vim.fn.getcwd()),
	settings = {
		bash = {
			diagnostics = {
				enable = true,
			},
		},
	},
})

-- === DIAGNOSTIC CONFIGURATION ===
-- Явная конфигурация отображения ошибок для унификации между системами
vim.diagnostic.config({
	virtual_text = {
		prefix = "●", -- или можно использовать "■", "▎", "x"
		source = "if_many", -- показывать источник только если несколько источников
		spacing = 4, -- расстояние между ошибкой и текстом
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true, -- сортировать по серьёзности
	float = {
		source = "always", -- показывать источник (pyright, luacheck и т.д.)
		border = "rounded",
		focusable = true,
	},
})

-- Если хочешь ещё более явные иконки (требует Nerd Font):
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = "󰋽 " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
