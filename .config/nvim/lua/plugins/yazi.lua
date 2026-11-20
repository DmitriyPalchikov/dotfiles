return {
  "mikavilpas/yazi.nvim",
  event = "UIEnter",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>fy", "<cmd>Yazi<cr>", desc = "Yazi (cwd)" },
    {
      "<leader>fY",
      function()
        require("yazi").yazi { cwd = vim.fn.expand "%:p:h" }
      end,
      desc = "Yazi (file dir)",
    },
  },
  opts = {
    -- открывать yazi вместо пустого буфера, если nvim запущен на директории
    open_for_directories = true,
  },
}
