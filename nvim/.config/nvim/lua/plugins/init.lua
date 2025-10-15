require("utils").load_modules("plugins", {
	"oil",
	"ts",
	"typpv",
	"copilot",
	"blcmp",
	"format",
	"runfile",
	"sniprun",
	"fzf",
	"colorize",
	"grug",
	"bamboo",
	"npairs",
})

require("plugins.bracket_region").setup()
