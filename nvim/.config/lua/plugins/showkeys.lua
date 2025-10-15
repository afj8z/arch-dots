vim.pack.add({
	{ src = 'https://github.com/NvChad/showkeys', opt = true },
})

require "showkeys".setup({
winopts = {
      relative = "editor",
      style = "minimal",
      border = "none",
      height = 1,
      row = 1,
      col = 0,
      zindex = 100,
    },
	position = "top-right",
	timeout = 1,
	maxkeys = 5,
	keyformat = {
		["<BS>"] = "bs",
		["<CR>"] = "cr",
		["<Space>"] = "spc",
		["<Up>"] = "󰁝",
		["<Down>"] = "󰁅",
		["<Left>"] = "󰁍",
		["<Right>"] = "󰁔",
		["<PageUp>"] = "Pg󰁝",
		["<PageDown>"] = "Pg󰁅",
		["<M>"] = "A-",
		["<C>"] = "C-",
		["<Leader>"] = "ldr",
	}
})

