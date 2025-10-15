local vo = vim.opt
local vg = vim.g
local vc = vim.cmd

vo.number = true
vo.cursorcolumn = false
vo.relativenumber = true
vo.signcolumn = "yes"
vo.termguicolors = true
vo.scrolloff = 4

vo.undofile = true
vo.swapfile = false
vim.o.winborder = '🬕,🬂,🬨,▐,🬷,🬭,🬲,▌'
vo.clipboard = "unnamedplus"
vg.clipboard = "wl-copy"
vo.incsearch = true
vo.ignorecase = true
vo.smartcase = true

vo.wrap = false
vo.tabstop = 4
vo.shiftwidth = 2
vo.smartindent = true

vg.have_nerd_font = true

vo.completeopt = { "menu", "menuone", "noinsert", "noselect" }
vc("set guicursor=")
vc("set updatetime=750")
