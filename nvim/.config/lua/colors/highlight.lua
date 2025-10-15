local M = {}

function M.sethighlights(colors)
	-- Terminal colors.
	vim.g.terminal_color_0          = colors.bg_dim_black
	vim.g.terminal_color_1          = colors.keyword
	vim.g.terminal_color_2          = colors.string
	vim.g.terminal_color_3          = colors.number
	vim.g.terminal_color_4          = colors.type
	vim.g.terminal_color_5          = colors.builtin
	vim.g.terminal_color_6          = colors.variable
	vim.g.terminal_color_7          = colors.ui_white
	vim.g.terminal_color_8          = colors.selection_bg
	vim.g.terminal_color_9          = colors.error
	vim.g.terminal_color_10         = colors.success
	vim.g.terminal_color_11         = colors.warning
	vim.g.terminal_color_12         = colors.info
	vim.g.terminal_color_13         = colors.hint
	vim.g.terminal_color_14         = colors.accent
	vim.g.terminal_color_15         = colors.highlight
	vim.g.terminal_color_background = colors.background
	vim.g.terminal_color_foreground = colors.foreground

	-- Groups used for statusline
	---@type table<string, vim.api.keyset.highlight>
	local statusline_groups         = {}
	for mode, color in pairs({
		Normal  = "type",
		Pending = "builtin",
		Visual  = "visual",
		Insert  = "ui_white",
		Command = "comment",
		Other   = "function_name",
	}) do
		statusline_groups["StatuslineMode" .. mode] = { fg = colors.background, bg = colors[color] }
		statusline_groups["StatuslineModeSeparator" .. mode] = { fg = colors[color], bg = "none" }
	end
	statusline_groups = vim.tbl_extend("error", statusline_groups, {
		StatuslineItalic  = { fg = colors.identifier, bg = colors.bg_dim_black, italic = true },
		StatuslineSpinner = { fg = colors.success, bg = colors.bg_dim_black, bold = true },
		StatuslineTitle   = { fg = colors.highlight, bg = colors.bg_dim_black, bold = true },
	})

	---@type table<string, vim.api.keyset.highlight>
	local groups = vim.tbl_extend("error", statusline_groups, {
		-- Language (syn.* semantics)
		Boolean                          = { fg = colors.number },
		Character                        = { fg = colors.string },
		Comment                          = { fg = colors.comment, italic = true },
		Conceal                          = { fg = colors.comment },
		Conditional                      = { fg = colors.keyword },
		Constant                         = { fg = colors.constant },
		Define                           = { fg = colors.keyword },
		Include                          = { fg = colors.keyword },
		Macro                            = { fg = colors.keyword },
		PreCondit                        = { fg = colors.keyword },
		PreProc                          = { fg = colors.keyword },
		Function                         = { fg = colors.function_name },
		Identifier                       = { fg = colors.identifier },
		Keyword                          = { fg = colors.keyword },
		Label                            = { fg = colors.constant },
		Number                           = { fg = colors.number },
		Operator                         = { fg = colors.keyword_secondary },
		Repeat                           = { fg = colors.keyword },
		Statement                        = { fg = colors.keyword },
		StorageClass                     = { fg = colors.keyword },
		Structure                        = { fg = colors.type },
		Type                             = { fg = colors.type },
		TypeDef                          = { fg = colors.type },

		-- UI (ui.* semantics)
		Normal                           = { fg = colors.foreground, bg = colors.background },
		NormalFloat                      = { fg = colors.foreground, bg = colors.menu_bg },
		NonText                          = { fg = colors.nontext_fg },
		EndOfBuffer                      = { fg = colors.background },

		ColorColumn                      = { bg = colors.selection_bg },
		CursorLine                       = { bg = colors.selection_bg },
		CursorColumn                     = { bg = colors.bg_dim_black },
		CursorLineNr                     = { fg = colors.type_secondary, bold = true },
		LineNr                           = { fg = colors.type_secondary },

		Directory                        = { fg = colors.function_name },
		Title                            = { fg = colors.type, bold = true },
		Underlined                       = { fg = colors.accent, underline = true },

		Pmenu                            = { fg = colors.ui_white, bg = colors.bg_dim_blue },
		PmenuSbar                        = { bg = colors.bg_dim_blue },
		PmenuSel                         = { fg = colors.ui_white, bg = colors.selection_bg },
		PmenuThumb                       = { bg = colors.nontext_fg },

		StatusLine                       = { fg = colors.ui_white, bg = "none" },
		VertSplit                        = { fg = colors.gutter_fg },
		SignColumn                       = { bg = colors.background },
		FoldColumn                       = {},
		Folded                           = { bg = colors.bg_dim_black },

		Search                           = { fg = colors.background, bg = colors.type },
		CurSearch                        = { fg = colors.ui_black, bg = colors.attribute },
		MatchParen                       = { bold = true, bg = colors.attribute, fg = colors.builtin },

		Special                          = { fg = colors.string, italic = true },
		SpecialComment                   = { fg = colors.comment, italic = true },
		SpecialKey                       = { fg = colors.nontext_fg },

		SpellBad                         = { sp = colors.error, underline = true },
		SpellCap                         = { sp = colors.warning, underline = true },
		SpellLocal                       = { sp = colors.hint, underline = true },
		SpellRare                        = { sp = colors.info, underline = true },

		Substitute                       = { bg = colors.attribute, fg = colors.background, bold = true },
		Todo                             = { fg = colors.accent, bold = true, italic = true },
		Visual                           = { bg = colors.visual_bg },
		VisualNOS                        = { fg = colors.visual_bg },
		WarningMsg                       = { fg = colors.warning },
		Error                            = { fg = colors.error },
		ErrorMsg                         = { fg = colors.error },
		WildMenu                         = { fg = colors.bg_dim_black, bg = colors.ui_white },

		Cursor                           = { bg = colors.foreground, fg = colors.background },
		-- Treesitter
		["@variable"]                    = { fg = colors.foreground },
		["@variable.builtin"]            = { fg = colors.keyword, bold = true },
		["@variable.parameter"]          = { fg = colors.ui_white },
		["@variable.member"]             = { fg = colors.property },

		["@constant"]                    = { fg = colors.constant },
		["@constant.builtin"]            = { fg = colors.constant },
		["@constant.macro"]              = { fg = colors.keyword },

		["@number"]                      = { fg = colors.number },
		["@number.float"]                = { fg = colors.number },

		["@boolean"]                     = { fg = colors.number },

		["@string"]                      = { fg = colors.string },
		["@string.regexp"]               = { fg = colors.property },
		["@string.escape"]               = { fg = colors.property, bold = true },
		["@string.special.symbol"]       = { fg = colors.constant },
		["@string.special.url"]          = { link = "Underlined" },

		["@character"]                   = { fg = colors.string },

		["@attribute"]                   = { fg = colors.attribute },
		["@annotation"]                  = { fg = colors.attribute },

		["@label"]                       = { fg = colors.constant },

		["@operator"]                    = { fg = colors.keyword_secondary },
		["@keyword.operator"]            = { fg = colors.keyword, bold = true },

		["@keyword"]                     = { fg = colors.keyword },
		["@keyword.conditional"]         = { fg = colors.keyword },
		["@keyword.repeat"]              = { fg = colors.keyword },
		["@keyword.exception"]           = { fg = colors.keyword },
		["@keyword.function"]            = { fg = colors.keyword },
		["@keyword.import"]              = { fg = colors.keyword },
		["@keyword.return"]              = { fg = colors.keyword },

		["@module"]                      = { fg = colors.number },
		["@module.builtin"]              = { fg = colors.number, bold = true },

		["@punctuation.delimiter"]       = { fg = colors.keyword },
		["@punctuation.bracket"]         = { fg = colors.attribute },
		["@punctuation.special"]         = { fg = colors.keyword },

		["@regexp"]                      = { fg = colors.property },

		["@property"]                    = { fg = colors.property },
		["@structure"]                   = { fg = colors.type },

		["@type"]                        = { fg = colors.type },
		["@type.builtin"]                = { fg = colors.type, bold = true },
		["@type.definition"]             = { fg = colors.type },
		["@type.qualifier"]              = { fg = colors.type },

		["@constructor"]                 = { fg = colors.function_name },

		["@function"]                    = { fg = colors.function_name },
		["@function.call"]               = { fg = colors.function_name },
		["@function.builtin"]            = { fg = colors.function_name },
		["@function.macro"]              = { fg = colors.keyword },
		["@function.method"]             = { fg = colors.function_name },
		["@function.method.call"]        = { fg = colors.function_name },

		["@error"]                       = { fg = colors.error },

		-- Markup
		["@markup"]                      = { fg = colors.foreground },
		["@markup.emphasis"]             = { fg = colors.accent, bold = true },
		["@markup.heading"]              = { fg = colors.type, bold = true },
		["@markup.link"]                 = { link = "Underlined" },
		["@markup.link.uri"]             = { link = "Underlined" },
		["@markup.list"]                 = { fg = colors.constant },
		["@markup.raw"]                  = { fg = colors.string },
		["@markup.strong"]               = { fg = colors.accent, bold = true },
		["@markup.underline"]            = { fg = colors.accent, underline = true },

		-- LSP semantic tokens
		["@class"]                       = { fg = colors.type },
		["@decorator"]                   = { fg = colors.function_name },
		["@enum"]                        = { fg = colors.type },
		["@enumMember"]                  = { fg = colors.constant },
		["@event"]                       = { fg = colors.number },
		["@interface"]                   = { fg = colors.type },

		["@lsp.type.class"]              = { fg = colors.type },
		["@lsp.type.decorator"]          = { fg = colors.function_name },
		["@lsp.type.enum"]               = { fg = colors.type },
		["@lsp.type.enumMember"]         = { fg = colors.constant },
		["@lsp.type.function"]           = { fg = colors.function_name },
		["@lsp.type.interface"]          = { fg = colors.type },
		["@lsp.type.macro"]              = { fg = colors.keyword },
		["@lsp.type.method"]             = { fg = colors.function_name },
		["@lsp.type.namespace"]          = { fg = colors.number },
		["@lsp.type.parameter"]          = { fg = colors.identifier },
		["@lsp.type.property"]           = { fg = colors.property },
		["@lsp.type.struct"]             = { fg = colors.type },
		["@lsp.type.type"]               = { fg = colors.type },
		["@lsp.type.variable"]           = { fg = colors.foreground },

		["@modifier"]                    = { fg = colors.keyword },
		["@struct"]                      = { fg = colors.type },
		["@typeParameter"]               = { fg = colors.type },

		-- LSP.
		DiagnosticDeprecated             = { strikethrough = true, fg = colors.foreground },
		DiagnosticError                  = { fg = colors.error },
		DiagnosticFloatingError          = { fg = colors.error },
		DiagnosticFloatingHint           = { fg = colors.hint },
		DiagnosticFloatingInfo           = { fg = colors.info },
		DiagnosticFloatingWarn           = { fg = colors.warning },
		DiagnosticHint                   = { fg = colors.hint },
		DiagnosticInfo                   = { fg = colors.info },
		DiagnosticUnderlineError         = { undercurl = true, sp = colors.background },
		DiagnosticUnderlineHint          = { undercurl = true, sp = colors.background },
		DiagnosticUnderlineInfo          = { undercurl = true, sp = colors.background },
		DiagnosticUnderlineWarn          = { undercurl = true, sp = colors.background },
		DiagnosticUnnecessary            = { fg = colors.identifier, italic = true },
		DiagnosticVirtualTextError       = { fg = colors.error, bg = colors.bg_dim_red },
		DiagnosticVirtualTextHint        = { fg = colors.hint, bg = colors.bg_dim_blue },
		DiagnosticVirtualTextInfo        = { fg = colors.info, bg = colors.bg_dim_blue },
		DiagnosticVirtualTextWarn        = { fg = colors.warning, bg = colors.bg_dim_yellow },
		DiagnosticWarn                   = { fg = colors.warning },

		LspCodeLens                      = { fg = colors.info },
		LspFloatWinBorder                = { fg = colors.comment },
		LspInlayHint                     = { fg = colors.keyword_secondary, italic = true },
		LspReferenceRead                 = { bg = colors.bg_dim_blue },
		LspReferenceText                 = {},
		LspReferenceWrite                = { bg = colors.bg_dim_red },
		LspSignatureActiveParameter      = { bold = true, underline = true, sp = colors.foreground },

		-- Completions:
		BlinkCmpKindClass                = { link = "@type" },
		BlinkCmpKindColor                = { link = "DevIconCss" },
		BlinkCmpKindConstant             = { link = "@constant" },
		BlinkCmpKindConstructor          = { link = "@type" },
		BlinkCmpKindEnum                 = { link = "@variable.member" },
		BlinkCmpKindEnumMember           = { link = "@variable.member" },
		BlinkCmpKindEvent                = { link = "@constant" },
		BlinkCmpKindField                = { link = "@variable.member" },
		BlinkCmpKindFile                 = { link = "Directory" },
		BlinkCmpKindFolder               = { link = "Directory" },
		BlinkCmpKindFunction             = { link = "@function" },
		BlinkCmpKindInterface            = { link = "@type" },
		BlinkCmpKindKeyword              = { link = "@keyword" },
		BlinkCmpKindMethod               = { link = "@function.method" },
		BlinkCmpKindModule               = { link = "@module" },
		BlinkCmpKindOperator             = { link = "@operator" },
		BlinkCmpKindProperty             = { link = "@property" },
		BlinkCmpKindReference            = { link = "@parameter.reference" },
		BlinkCmpKindSnippet              = { link = "@markup" },
		BlinkCmpKindStruct               = { link = "@structure" },
		BlinkCmpKindText                 = { link = "@markup" },
		BlinkCmpKindTypeParameter        = { link = "@variable.parameter" },
		BlinkCmpKindUnit                 = { link = "@variable.member" },
		BlinkCmpKindValue                = { link = "@variable.member" },
		BlinkCmpKindVariable             = { link = "@variable" },
		BlinkCmpLabelDeprecated          = { link = "DiagnosticDeprecated" },
		BlinkCmpLabelDescription         = { fg = colors.identifier, italic = true },
		BlinkCmpLabelDetail              = { fg = colors.identifier, bg = colors.menu_bg },
		BlinkCmpMenu                     = { bg = colors.menu_bg },
		BlinkCmpMenuBorder               = { bg = colors.menu_bg },

		-- SnipRun
		SniprunVirtualTextOk             = { fg = colors.success, bg = colors.bg_dim_black },
		SniprunVirtualTextErr            = { fg = colors.error, bg = colors.bg_dim_black },

		-- Diffs.
		DiffAdd                          = { fg = colors.success, bg = colors.bg_dim_green },
		DiffChange                       = { fg = colors.ui_white, bg = colors.bg_dim_yellow },
		DiffDelete                       = { fg = colors.error, bg = colors.bg_dim_red },
		DiffText                         = { fg = colors.constant, bg = colors.bg_dim_yellow, bold = true },
		DiffviewFolderSign               = { fg = colors.info },
		DiffviewNonText                  = { fg = colors.type_secondary },
		diffAdded                        = { fg = colors.success, bold = true },
		diffChanged                      = { fg = colors.warning, bold = true },
		diffRemoved                      = { fg = colors.error, bold = true },

		-- Yanking
		YankHighlight                    = { bg = colors.constant, fg = colors.background },

		-- Command line.
		MoreMsg                          = { fg = colors.highlight, bold = true },
		MsgArea                          = { fg = colors.info },
		MsgSeparator                     = { fg = colors.type_secondary },

		-- Winbar styling.
		WinBar                           = { fg = colors.foreground, bg = colors.bg_dim_black },
		WinBarNC                         = { bg = colors.bg_dim_black },
		WinBarDir                        = { fg = colors.hint, bg = colors.bg_dim_black, italic = true },
		WinBarSeparator                  = { fg = colors.success, bg = colors.bg_dim_black },

		-- Quickfix window.
		QuickFixLine                     = { italic = true, bg = colors.bg_dim_red },

		-- Gitsigns.
		GitSignsAdd                      = { fg = colors.success },
		GitSignsChange                   = { fg = colors.info },
		GitSignsCurrentLineBlame         = { fg = colors.keyword_secondary },
		GitSignsDelete                   = { fg = colors.error },
		GitSignsStagedAdd                = { fg = colors.constant },
		GitSignsStagedChange             = { fg = colors.constant },
		GitSignsStagedDelete             = { fg = colors.constant },

		-- Gitlinker.
		NvimGitLinkerHighlightTextObject = { link = "Visual" },

		-- Bufferline.
		BufferLineBufferSelected         = { bg = colors.menu_bg, underline = true, sp = colors.type },
		BufferLineFill                   = { bg = colors.background },
		TabLine                          = { fg = colors.comment, bg = colors.background },
		TabLineFill                      = { bg = colors.background },
		TabLineSel                       = { bg = colors.type },

		-- Flash.
		FlashBackdrop                    = { italic = true },
		FlashPrompt                      = { link = "Normal" },

		-- Titles.
		MiniClueTitle                    = { bold = true, fg = colors.info },
		MiniFilesTitleFocused            = { bold = true, fg = colors.info },

		-- Treesitter sticky context.
		TreesitterContextBottom          = { underline = true, sp = colors.type_secondary },

		-- Fzf overrides.
		FzfLuaBorder                     = { fg = colors.comment },
		FzfLuaHeaderBind                 = { fg = colors.keyword_secondary },
		FzfLuaHeaderText                 = { fg = colors.builtin },
		FzfLuaLivePrompt                 = { link = "Normal" },
		FzfLuaLiveSym                    = { fg = colors.attribute },
		FzfLuaPreviewTitle               = { fg = colors.foreground },
		FzfLuaSearch                     = { bg = colors.bg_dim_red },

		-- Nicer sign column highlights for grug-far.
		GrugFarResultsChangeIndicator    = { link = "Changed" },
		GrugFarResultsRemoveIndicator    = { link = "Removed" },
		GrugFarResultsAddIndicator       = { link = "Added" },

		-- Overseer.
		OverseerComponent                = { link = "@keyword" },

		-- Links.
		HighlightUrl                     = { underline = true, fg = colors.neon_accent, sp = colors.neon_accent },

		-- Rainbow Matching Brackets.

		RainbowDelimiterRed              = { fg = colors.number },
		RainbowDelimiterYellow           = { fg = colors.type },
		RainbowDelimiterBlu              = { fg = colors.keyword },
		RainbowDelimiterOrang            = { fg = colors.accent },
		RainbowDelimiterGreen            = { fg = colors.attribute },
		RainbowDelimiterViolet           = { fg = colors.number },
		RainbowDelimiterCyan             = { fg = colors.constant },

		-- Telescope

		TelescopeNormal                  = { bg = colors.menu_bg },
	})
	return groups
end

return M
