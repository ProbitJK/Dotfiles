local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

local date = function()
    return { os.date('%Y-%m-%d') }
end

ls.add_snippets("all", {
    s(
        {
            trig = "me",
            dscr = "My NAME !!!!",
        },
        {
            t("Probit Jyoti Kalita"),
        }
    ),
    s(
        {
            trig = "date",
            dscr = "Today's date in YYYY-MM-DD format",
        },
        {
            f(date, {}),
        }
    ),
    s("snip",
        fmt(
            [[
                s(
                {
                    trig = "<1>",
                    namr = "<2>",
                    dscr = "<3>",
                },
                <4>
                ),
                ]],
            {
                i(1, "trigger text"), i(2, "snippet name"), i(3, "description"), i(4, "snippet")
            },
            {
                delimiters = "<>"
            }
        )
    ),
})
