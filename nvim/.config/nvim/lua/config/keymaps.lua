-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

vim.keymap.set('n', '<C-Left>', '<C-w>h', { desc = 'Go to left split' })
vim.keymap.set('n', '<C-Down>', '<C-w>j', { desc = 'Go to lower split' })
vim.keymap.set('n', '<C-Up>', '<C-w>k', { desc = 'Go to upper split' })
vim.keymap.set('n', '<C-Right>', '<C-w>l', { desc = 'Go to right split' })

vim.keymap.set('n', '<M-Left>', '<C-w><', { desc = 'Resize split left' })
vim.keymap.set('n', '<M-Down>', '<C-w>-', { desc = 'Resize split down' })
vim.keymap.set('n', '<M-Up>', '<C-w>+', { desc = 'Resize split up' })
vim.keymap.set('n', '<M-Right>', '<C-w>>', { desc = 'Resize split right' })

vim.keymap.set('n', '<C-Tab>', '<Cmd>bn<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<C-S-Tab>', '<Cmd>bp<CR>', { desc = 'Previous buffer' })
