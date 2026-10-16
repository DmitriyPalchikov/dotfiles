return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require('gitsigns').setup({
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
            signcolumn = true,
            update_debounce = 100,
            _allow_fs_poll_fallback = true,
            attach_to_untracked = true,
            current_line_blame = true,
            current_line_blame_formatter = function(name, blame_info, opts)
                if blame_info.author == "Not Committed Yet" then
                    return { { "  " .. blame_info.author, "GitSignsCurrentLineBlame" } }
                end
                local sha = blame_info.abbrev_sha
                local date = os.date("%m-%d-%Y %H:%M:%S", blame_info.author_time)
                local text = string.format(
                    " %s • %s • %s • <%s>",
                    blame_info.summary, date, blame_info.author, sha
                )
                return { { text, "GitSignsCurrentLineBlame" } }
            end,
            watch_gitdir = { enable = true, follow_files = true },
        })

        vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk<CR>', {})
    end,
}
