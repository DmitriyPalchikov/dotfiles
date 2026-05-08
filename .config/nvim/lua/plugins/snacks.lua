return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  ---@type snacks.Config
  opts = {
    indent = {
      priority = 1,
      enabled = true, -- enable indent guides
      char = "│",
      only_scope = false, -- only show indent guides of the scope
      only_current = false, -- only show indent guides in the current window
      hl = "SnacksIndent", ---@type string|string[] hl groups for indent guides
    },
    lazygit = {
        enabled = true,
    },
    terminal = {
        enabled = true,
    },
    statuscolumn = {
      enabled = true,
      folds = {
        open = true,
      },
    },
  }
}
