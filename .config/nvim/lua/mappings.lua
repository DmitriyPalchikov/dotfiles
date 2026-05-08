require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")




-- ТАБЫ 
-- Навигация по табам
map('n', '<leader>]', ':tabnext<CR>', { desc = 'Next tab' })
map('n', '<leader>[', ':tabprevious<CR>', { desc = 'Prev tab' })

-- Или через Alt
map('n', '<A-]>', ':tabnext<CR>', { desc = 'Next tab' })
map('n', '<A-[>', ':tabprevious<CR>', { desc = 'Prev tab' })

-- Создание / закрытие 
map('n', '<leader>tn', ':tabnew<CR>', { desc = 'New tab' })
map('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close tab' })




-- НАСТРОЙКИ REPLACE 
-- Маппинг
map('n', '<leader>sr', function()
  require('grug-far').open()
end, { desc = 'Search & Replace' })

-- Заменить слово под курсором
map('n', '<leader>sw', function()
  require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>') } })
end, { desc = 'Search word under cursor' })


-- TERMINAL
map('t', '<Esc><Esc>', '<C-\\><C-n>', { noremap = true })


-- LAZYGIT
map("n", "<leader>gG", function()
  Snacks.lazygit()
end, { desc = "Lazygit (cwd)" })

-- FOLDS
map("n", "<leader>za", "za", { remap = true, desc = "Toggle fold" })
map("n", "<leader>zR", function()
  require("ufo").openAllFolds()
end, { desc = "Open all folds" })
map("n", "<leader>zM", function()
  require("ufo").closeAllFolds()
end, { desc = "Close all folds" })
