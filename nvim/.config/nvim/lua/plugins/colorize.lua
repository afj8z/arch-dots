vim.pack.add({
	{ src = "https://github.com/catgoose/nvim-colorizer.lua.git" }
})


-- 	local names = {}
-- 	for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
-- 		-- match 6 or 8 hex digits, with or without quotes, optional leading #
-- 		-- examples it catches: 1c1a1c, "1c1a1c", '#1c1a1c', "E0CACEFF"
-- 		for hex in line:gmatch([["?%s*#?([%x][%x][%x][%x][%x][%x][%x]?[%x]?)%s*"?]]) do
-- 			local h = hex:lower()
-- 			if #h == 6 or #h == 8 then
-- 				names[h] = "#" .. h
-- 			end
-- 		end
-- 	end
-- 	return names
-- end

require("colorizer").setup({
	user_default_options = {
		names = false,
		css = true,
	},
})
