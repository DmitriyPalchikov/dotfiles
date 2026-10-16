return {
  "Geertsky/ansible-doc.nvim",
  config = function()
    require("ansible_doc").setup({
        mapping = "<leader>ad",
    })
  end,
}
