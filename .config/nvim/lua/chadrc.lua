-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
    theme = "kanagawa",
    transparency = true,

    hl_add = {
        GitSignsCurrentLineBlame = { fg = "#8a8a93" },
    },

    hl_override = {
        Comment = { italic = true },
        ["@comment"] = { italic = true },
    },
}

M.nvdash = {
    load_on_startup = true,
    header = {
        "██████╗  ██████╗ ███╗   ██╗███████╗██╗",
        "██╔══██╗██╔═══██╗████╗  ██║╚══███╔╝██║",
        "██████╔╝██║   ██║██╔██╗ ██║  ███╔╝ ██║",
        "██╔══██╗██║   ██║██║╚██╗██║ ███╔╝  ██║",
        "██████╔╝╚██████╔╝██║ ╚████║███████╗██║",
        "╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚═╝",
    },
    buttons = {
        { txt = "🎄  Find File", keys = "Spc f f", cmd = "Telescope find_files" },
        { txt = "📄  Recent Files", keys = "Spc f o", cmd = "Telescope oldfiles" },
        { txt = "🦙  Find Word", keys = "Spc f w", cmd = "Telescope live_grep" },
        -- { txt = "🏷️  Bookmarks", keys = "Spc m a", cmd = "Telescope marks" },
        { txt = "🎨  Themes", keys = "Spc t h", cmd = "Telescope themes" },
        { txt = "🧪  Mappings", keys = "Spc c h", cmd = "NvCheatsheet" },

        { txt = "─", hl = "NvDashLazy", no_gap = true, rep = true },
        {
            txt = function()
                local stats = require("lazy").stats()
                local ms = math.floor(stats.startuptime) .. " ms"
                return "🚀 Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
            end,
            hl = "NvDashLazy",
            no_gap = true,
        },
        { txt = "─", hl = "NvDashLazy", no_gap = true, rep = true },
    },
}

return M
