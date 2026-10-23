vim.o.autoindent = true;
vim.o.conceallevel = 2;
vim.o.cursorline = true;
vim.o.expandtab = true;
vim.o.foldlevelstart = 99;
vim.o.ignorecase = true;
vim.o.incsearch = true;
vim.o.infercase = true;
vim.o.linebreak = true;
vim.o.number = true;
vim.o.relativenumber = true;
vim.o.shell = "/run/current-system/sw/bin/nu";
vim.o.shiftwidth = 4;
vim.o.shortmess = "CFIOSWaco";
vim.o.showmode = false;
vim.o.signcolumn = "yes";
vim.o.smartcase = true;
vim.o.softtabstop = 4;
vim.o.splitbelow = true;
vim.o.splitkeep = "screen";
vim.o.splitright = true;
vim.o.switchbuf = "usetab";
vim.o.tabstop = 4;
vim.o.termguicolors = true;
vim.o.timeoutlen = 400;
vim.o.undofile = true;
vim.o.virtualedit = "block";
vim.o.wrap = true;

vim.opt.clipboard = "unnamedplus"

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.lsp.enable('nixd')
vim.lsp.enable('nimlangserver')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('gdscript')
vim.lsp.enable('ty')
vim.lsp.enable('clangd')

require('plugins')
require('mappings')

vim.filetype.add({
	extension = {
		rv = "revo",
		revo = "revo",
	},
})

vim.lsp.config("revo", {
	cmd = { "revo", "lsp" },
	filetypes = { "rv", "revo" },
	root_markers = {
		"lib.json",
		"exe.json",
		".git",
	},
})

vim.lsp.enable("revo")

vim.treesitter.language.register("revo", {
	"rv",
	"revo",
})

require("nvim-treesitter").setup({
	local_parsers = {
		revo = {
			source = {
				type = "git",
				url = "https://codeberg.org/doomy/tree-sitter-revo",
				revision = "main",
			},
			filetype = "revo",
		},
	},
})

require("nvim-treesitter").install({ "revo" })

require('autocmds')
