return {
  "kkrampis/codex.nvim",
  cmd = { "Codex", "CodexToggle" },
  keys = {
    {
      '<leader>cc', -- Change this to your preferred keybinding
      function() require('codex').toggle() end,
      desc = 'Toggle Codex popup or side-panel',
      mode = { 'n', 't' }
    },
  },
  opts = {
    keymaps = { 
        quit = '<C-q>',
    },
    model = "gpt-5.4",
    panel       = true,
    width       = 0.3,
    autoinstall = true,
  },
}
