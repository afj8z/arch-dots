local cp = {
	-- UI & BASE
	bg = "#EBDCB7", -- [REQUESTED] Warm beige background
	bg_trans = "rgba(235, 220, 183, 0.96)",
	fg = "#3C3836", -- Dark warm grey/brown for main text
	bg_dim = "#D5C4A1", -- Slightly darker beige for inactive UI
	cursorline = "#DCC7A0", -- Subtle darken for current line
	selection = "#C9B998", -- Darker beige/tan for selection
	float = "#E0D0AB", -- Slightly lighter popup/float background

	-- TEXT ACCENTS
	comment = "#928374", -- Muted earth tone
	punct = "#A89984", -- Lighter brown/grey
	accent = "#689D6A", -- Forest Green (Selected text)
	transparent = "NONE",

	-- SYNTAX COLORS
	-- Reds & Pinks (Darkened for contrast)
	red = "#9D0006", -- Keyword, Return (Deep Red)
	error_red = "#CC241D", -- Errors (Bright Red)
	pink = "#B16286", -- Numbers, Booleans (Magenta)
	maroon = "#8F3F48", -- Exception (Brick Red)

	-- Oranges & Yellows
	orange = "#D65D0E", -- Modules (Burnt Orange)
	coral = "#AF3A03", -- Operators (Rust)
	warning = "#D79921", -- Warnings (Mustard/Dark Gold)
	gold = "#B57614", -- Special, Debug (Bronze)

	-- Greens
	green = "#608B4E", -- Strings (Leaf Green)
	lime = "#79740E", -- Regex (Olive)

	-- Blues & Teals
	teal = "#458588", -- Functions (Teal)
	cyan = "#2E7986", -- Builtins (Dark Cyan)
	blue = "#076678", -- [UNUSED]
	indigo = "#427b58", -- Constants (Deep Sea Green/Blue)

	-- Purples
	purple = "#8F3F71", -- Conditionals (Deep Purple)
	lavender = "#896a96", -- [UNUSED]

	-- Neutrals / Data Family
	beige = "#504945", -- Constants (Dark Brown - inverted from light beige)
	stone = "#665C54", -- Parameters (Dark Grey)
	wheat = "#7C6F64", -- Fields (Medium Grey-Brown)
}
