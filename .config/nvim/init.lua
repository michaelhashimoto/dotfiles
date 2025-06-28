vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<D-C-j>", ":m .+1<cr>")
vim.keymap.set("n", "<D-C-k>", ":m .-2<cr>")

vim.api.nvim_set_option("clipboard", "unnamedplus")

vim.keymap.set("v", "y", [["+y]])
vim.keymap.set("n", "<leader>y", [["+Y]])

vim.opt.fixeol = false
vim.opt.number = true
vim.opt.relativenumber = true
