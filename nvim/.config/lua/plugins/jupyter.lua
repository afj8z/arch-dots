vim.pack.add({
	{
		src = "https://github.com/kiyoon/jupynium.nvim",
		run =
		"uv pip install . --python=$HOME/.virtualenvs/jupynium/bin/python"
	},
})

require("jupynium").setup({
	python_host = vim.fn.expand("/home/aidfj/.python/venv/bin/python3"),
})
