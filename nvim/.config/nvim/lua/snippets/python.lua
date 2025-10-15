local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Helper to make punctuation-led autosnips concise
local function AS(trig, nodes)
	return s({ trig = trig, wordTrig = false, snippetType = "autosnippet" }, nodes)
end

return {
	-- Optionals / Unions
	AS(";on", { t(" | None") }),
	AS(";u", { t(" | "), i(1) }),
	AS(";opt", { t("Optional["), i(1, "T"), t("]") }),
	AS(";U", { t("Union["), i(1, "A"), t(", "), i(2, "B"), t("]") }),

	-- Collections / ABCs
	AS(";l", { t("list["), i(1, "T"), t("]") }),
	AS(";t", { t("tuple["), i(1, "A"), t(", "), i(2, "B"), t("]") }),
	AS(";d", { t("dict["), i(1, "K"), t(", "), i(2, "V"), t("]") }),
	AS(";s", { t("set["), i(1, "T"), t("]") }),
	AS(";m", { t("Mapping["), i(1, "K"), t(", "), i(2, "V"), t("]") }),
	AS(";it", { t("Iterable["), i(1, "T"), t("]") }),
	AS(";seq", { t("Sequence["), i(1, "T"), t("]") }),

	-- Callable / Annotated / Literal
	AS(";cb", { t("Callable[["), i(1, "Args"), t("], "), i(2, "Ret"), t("]") }),
	AS(";ann", { t("Annotated["), i(1, "T"), t(", "), i(2, "..."), t("]") }),
	AS(";lit", { t("Literal["), i(1, "..."), t("]") }),

	-- Type variables & aliases
	AS(";TV", { t("T = TypeVar('T')") }),
	AS(";PS", { t("P = ParamSpec('P')") }),
	AS(";ta", { i(1, "Name"), t(": TypeAlias = "), i(2, "T") }),
}
