vim.pack.add({
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{
		src = "https://github.com/Saghen/blink.cmp",
		version = "v1.6.0",
	},
})

require("luasnip").config.setup({ enable_autosnippets = true })

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").load({
	paths = "~/.config/nvim/lua/snippets/",
})

require("blink.cmp").setup({
	signature = { enabled = true },
	completion = {
		ghost_text = { enabled = true },
		documentation = { auto_show = true, auto_show_delay_ms = 0 },
		menu = {
			auto_show = true,
			max_height = 7,
			border = "none",
			draw = {
				-- treesitter = { "lsp" },
				columns = { { "label", "label_description", gap = 1 }, { "kind" } },
			},
		},
		list = {
			selection = {
				preselect = false,
				auto_insert = true,
			},
		},
	},
	snippets = { preset = "luasnip" },
	sources = {
		default = { "lsp", "path", "buffer" },
		providers = {
			lsp = {
				timeout_ms = 10000,
			},
		},
	},
	keymap = {
		["<Tab>"] = {
			function(cmp)
				if cmp.snippet_active() then
					return cmp.accept()
				else
					return cmp.select_and_accept()
				end
			end,
			"snippet_forward",
			"fallback",
		},
	},
	fuzzy = {
		implementation = "prefer_rust_with_warning",
	},

	term = {
		enabled = true,
	},
	cmdline = {
		keymap = { preset = "inherit" },
		completion = { menu = { auto_show = true } },
	},
	appearance = {
		use_nvim_cmp_as_default = false,
	},
})

vim.api.nvim_create_autocmd("User", {
	pattern = "BlinkCmpMenuOpen",
	callback = function()
		vim.b.copilot_suggestion_hidden = true
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "BlinkCmpMenuClose",
	callback = function()
		vim.b.copilot_suggestion_hidden = false
	end,
})
