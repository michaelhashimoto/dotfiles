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
	{ "catppuccin/nvim", name = "catppuccin" },
	{ "nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim"
		}
	},
	{ "nvim-treesitter/nvim-treesitter", build= ":TSUpdate" },
}

require("lazy").setup(plugins, opts)

require("catppuccin").setup()

vim.cmd.colorscheme("catppuccin")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

require("nvim-treesitter.configs").setup({
	ensure_installed = {"lua", "javascript"},
	highlight = { enable = true },
	indent = { enable = true },
})

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

-- Optional: Start with all folds open
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true