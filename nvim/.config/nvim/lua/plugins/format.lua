vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
})

require("conform").setup({
	format_on_save = {
		timeout_ms = 1000,
		lsp_format = "fallback",
	},
	Formatters_by_ft = {
		typst = { "typstyle" },
		python = { "ruff", "black" },
		lua = { "stylua" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		javascriptreact = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		typescriptreact = { "prettierd", "prettier", stop_after_first = true },
		json = { "prettierd", "prettier", stop_after_first = true },
		shellscript = { "prettierd", "prettier", stop_after_first = true },
		markdown = { "prettierd", "prettier", stop_after_first = true },
		stata = { "statafmt" },
	},
	formatters = {
		statafmt = {
			command = "statafmt", -- the script above
			args = { "--width", "40", "--cont-indent", "2" },
			stdin = true,
		},
	},
})

-- allows eslint + prettier to work in tandem
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		vim.lsp.buf.format()
	end,
})
