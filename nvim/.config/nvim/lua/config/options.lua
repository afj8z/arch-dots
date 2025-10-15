local vo = vim.opt
local vg = vim.g
local vc = vim.cmd

vo.number = true
vo.cursorcolumn = false
vo.relativenumber = true
vo.signcolumn = "yes"
vo.termguicolors = true
vo.scrolloff = 4
vo.textwidth = 80

vo.undofile = true
vo.swapfile = false
vo.winborder = "solid"
vo.splitright = true
vo.clipboard = "unnamedplus"
vg.clipboard = "wl-copy"
vo.inccommand = "split"
vo.incsearch = true
vo.ignorecase = true
vo.smartcase = true
vo.hlsearch = true
vo.title = true

vo.conceallevel = 0
vo.concealcursor = "nc"
vo.wrap = false
vo.tabstop = 4
vo.shiftwidth = 4
vo.smartindent = true

vg.have_nerd_font = true

vo.completeopt = { "menu", "menuone", "noselect" }

vim.opt.guicursor = "n-v-c:block,i-ci-r:block-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,o:hor400-Cursor"

vc("set updatetime=750")
