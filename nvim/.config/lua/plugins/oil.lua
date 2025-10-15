vim.pack.add({

	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/JezerM/oil-lsp-diagnostics.nvim" },
})

require "oil".setup()
require "oil-lsp-diagnostics".setup({
	diagnostic_symbols = {
		error = "x",
		warn = "!",
		info = "i",
		hint = "?",
	}
})
