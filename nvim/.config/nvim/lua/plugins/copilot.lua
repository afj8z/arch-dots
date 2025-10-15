vim.pack.add({
	{ src = "https://github.com/zbirenbaum/copilot.lua.git" },
})

require("copilot").setup({
	suggestion = {
		enabled = true,
		auto_trigger = true,
		hide_during_completion = true,
		debounce = 75,
		trigger_on_accept = true,
		keymap = {
			accept = "<M-l>",
			accept_word = false,
			accept_line = "<C-A>",
			next = "<M-]>",
			prev = "<M-[>",
			dismiss = "<C-]>",
		},
	},
})
