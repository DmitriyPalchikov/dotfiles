require "nvchad.autocmds"

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        local cwd = vim.uv.cwd()
        if not cwd or vim.fn.isdirectory(cwd) == 0 then
            vim.cmd("cd " .. vim.fn.fnameescape(vim.env.HOME or "~"))
        end
    end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "DirChanged" }, {
    group = vim.api.nvim_create_augroup("GitRefresh", { clear = true }),
    callback = function()
        pcall(vim.cmd, "Gitsigns refresh")
        if package.loaded["nvim-tree.api"] then
            pcall(require("nvim-tree.api").tree.reload)
        end
    end,
})
