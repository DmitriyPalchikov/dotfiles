local parsers = {
  "bash", "fish", "lua", "luadoc", "markdown", "printf", "python",
  "toml", "vim", "vimdoc", "yaml", "dockerfile", "go", "gomod",
  "gosum", "gotmpl", "gowork", "helm",
}

require("nvim-treesitter").install(parsers)

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true }),
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})
