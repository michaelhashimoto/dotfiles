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

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local opts = {}
local plugins = {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { "nvim-telescope/telescope.nvim", tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim"
        }
    }
}

require("lazy").setup(plugins, opts)

require("catppuccin").setup()

vim.cmd.colorscheme("catppuccin")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})