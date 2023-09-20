local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local rep = require("luasnip.extras").rep
local fmta = require("luasnip.extras.fmt").fmta

ls.add_snippets(nil, {
    markdown = {
        s(
            {
                trig = "title",
                namr = "Fancy header",
                dscr = "Create title and change page color",
            },
            fmta(
                [[
                ---
                title: <1>
                date: date<2>
                header-includes:
                    - \usepackage[a4paper]{geometry}
                    - \usepackage{fullpage}
                    - \usepackage{xcolor}
                    - \pagecolor[HTML]{1e1e2e}
                    - \color[HTML]{cdd6f4}
                ---
                ]],
                {
                    i(1, "Title of document"), i(2)
                }
            )
        ),
    },
})
