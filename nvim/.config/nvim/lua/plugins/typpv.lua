vim.pack.add({
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
})

require("typst-preview").setup({
	dependencies_bin = { ["tinymist"] = "tinymist" },
	open_cmd = 'firefox --new-window --no-remote -P "preview-profile" %s',
	invert_colors = '{"rest": "always","image": "never"}',
	follow_cursor = true,
})
