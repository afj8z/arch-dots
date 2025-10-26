local cp = {{

		white = "{{{{custom.myfrontacc}}}}",
		transparent = "NONE",

		gray = {{
				_1000 = "{{{{custom.myblack}}}}",
				_950 = "{{{{custom.mysurface}}}}",
				_900 = "{{{{custom.mysurfacedim}}}}",
				_800 = "{{{{custom.mysurfaceacc}}}}",
				_700 = "{{{{custom.mytextdim}}}}",
				_500 = "{{{{custom.mytextmid}}}}",
				_400 = "{{{{custom.mytext}}}}",
				_200 = "{{{{custom.mytextacc}}}}",
				_50 = "{{{{custom.myfront}}}}",
			}},

		orange = {{
			_500 = "{color3}",
		}},

		red = {{
				_400 = "{color5}", -- NOTE: Alias rose._200.
				_500 = "{color1}",
				_600 = "{color9}",
				_800 = "#121212",
				_900 = "#030303",
			}},

		indigo = {{
				_400 = "{color12}", -- NOTE: Alias violet._200.
				_500 = "{color4}",
				_800 = "#2a2a2a",
				_900 = "#0a0a0a",
			}},

		green = {{
			_500 = "{color2}",
			_600 = "{color10}",
			_900 = "#343B34",
		}},

		sky = {{
			_500 = "{color14}",
		}},

		opal = {{
			_500 = "{color7}",
		}},

		sand = {{
			_500 = "{color11}",
		}},
		ext = {{
			_visual = "{{{{custom.myvisual}}}}",
			_hl = "{{{{custom.myselect}}}}",
			_num = "{color13}",
		}},
}}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {{}}, "overwrite", "colors") or {{}}
return vim.tbl_deep_extend("force", cp, overwrite)
