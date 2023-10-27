local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = ' '

-- Árbol
map('n', '<A-g>', ':NvimTreeToggle<CR>', opts)

-- Formato de documento
map('n', '<C-a>', ':lua vim.lsp.buf.format()<CR>', opts)

-- Guardados y pestañas
map('n', '<C-s>', ':noa w<CR>', opts)
map('n', '<C-o>', ':bprev<CR>', opts)
map('n', '<C-p>', ':bnext<CR>', opts)

-- Hop motion
map('n', '<A-y>', ':HopWord<CR>', opts)

-- Telescope
map('n', '<A-t>', ':Telescope<CR>', opts)

-- Teclas más usadas con ALT
map('!', '<A-j>', '+', opts)
map('!', '<A-k>', '-', opts)
map('!', '<A-m>', '*', opts)
map('!', '<A-,>', '/', opts)
map('!', '<A-h>', '%', opts)
map('!', '<A-l>', '=', opts)
map('!', '<A-u>', "'", opts)
map('!', '<A-i>', '"', opts)
map('!', '<A-o>', '$', opts)

map('n', '<A-ñ>', '<esc>', opts)

map('!', '<A-q>', '|', opts)
map('!', '<A-w>', '&', opts)
map('!', '<A-a>', '{', opts)
map('!', '<A-s>', '}', opts)
map('!', '<A-d>', '(', opts)
map('!', '<A-f>', ')', opts)
map('!', '<A-z>', '<', opts)
map('!', '<A-x>', '>', opts)
map('!', '<A-c>', '[', opts)
map('!', '<A-v>', ']', opts)

