local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
    s("trig", { t("Wohoo!") }),
    s("hey", t({ "two lines now?", "yeah!" })),
    s("many", { t({ "Come here ->" }), i(1), t({ "", "And finally here ->" }), i(3), t({ "", "Now here ->" }), i(2) }),
}

-- return {
--     require("luasnip").snippet({ trig = "hi" }, { t("Hello, world!") }),
--     require("luasnip").snippet({ trig = "foo" }, { t("Another snippet.") }),
--     require("luasnip").snippet({ trig = "what" }, { t("WTF?") }),
-- }
