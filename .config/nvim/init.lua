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
vim.opt.list = true
vim.opt.listchars = {
	tab = ">-",
	space = "·",
}
vim.opt.shiftwidth = 4

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
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim"
		}
	},
	{ "nvim-treesitter/nvim-treesitter", build= ":TSUpdate" },
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				current_line_blame = true, -- enable git blame on current line
				current_line_blame_opts = {
					delay = 500,
					virt_text = true,
				},
			})

			vim.keymap.set("n", "<C-D-n>", ":Gitsigns nav_hunk next<cr>")
			vim.keymap.set("n", "<C-D-p>", ":Gitsigns nav_hunk prev<cr>")
		end
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- optional: auto-update registry
		config = function()
			require("mason").setup()
		end
	},
	{
		"mfussenegger/nvim-jdtls",
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",            -- optional helper
			"williamboman/mason-lspconfig.nvim",  -- optional helper
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "jdtls" },  -- auto install jdtls if not installed
			})
		end
	},
	{
		"nvim-java/nvim-java",
		dependencies = {
			"nvim-java/lua-async-await",
			"nvim-java/nvim-java-core",
			"nvim-java/nvim-java-test",
			"nvim-java/nvim-java-dap",
			"nvim-java/nvim-java-refactor",
			"mfussenegger/nvim-jdtls", -- required to run jdtls
		},
	},
	{
		"tpope/vim-fugitive",
	},
	{
		"petertriho/nvim-scrollbar",
			dependencies = { "lewis6991/gitsigns.nvim" },
			opts = {
			handlers = {
			    gitsigns = true,
			},
		},
		config = function()
			require("scrollbar").setup()
			require("scrollbar.handlers.gitsigns").setup()
		end
	},
}

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true })
vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "Go to references" })

vim.keymap.set('n', 'gO', function()
  require('jdtls').super_implementation()
end, { desc = "Go to Super Implementation" })

vim.keymap.set('n', 'gi', function()
  require('jdtls').implementations()
end, { desc = "Go to Implementations (Overrides)" })

require("lazy").setup(plugins, opts)

require("catppuccin").setup()

vim.cmd.colorscheme("catppuccin")

local builtin = require("telescope.builtin")

require('telescope').setup({
  defaults = {
    file_ignore_patterns = {
      "%.class$",      -- ignore all `.class` files
      "%.jar$",        -- (optional) ignore `.jar` files
      "node_modules",  -- ignore entire `node_modules` directory
      "%.log$",        -- ignore log files
    },
  }
})

vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<C-b>", builtin.buffers, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"lua",
		"java",
		"javascript",
		"properties",
		"xml",
		"yaml",
	},
	highlight = { enable = true },
	indent = { enable = true },
})

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

-- Optional: Start with all folds open
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<cr>")

require("neo-tree").setup({
	filesystem = {
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = false,
			hide_hidden = false,
		}
	}
});