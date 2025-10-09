local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
local rep = require("luasnip.extras").rep
local fmta = require("luasnip.extras.fmt").fmta

local date = function()
    return { os.date('%Y-%m-%d') }
end

ls.add_snippets(nil, {
    python = {
        s(
        {
            trig = "fn",
            namr = "Function",
            dscr = "Create a function",
        },
        fmta([[
        def <f_name>(<args>)<r_type>:
            <body>
        <ret>
        ]],
        {
            f_name = i(1, "function_name"),
            args = i(2),
            body = i(3, "function body"),
            ret = c(4, {
                t(""),
                sn(nil, {
                    t("    return "),
                    i(4),
                }),
            }),
            r_type = c(5, {
                t(""),
                sn(nil, {
                    t(" -> "),
                    i(5, "return type"),
                }),
            }),
        })
        ),
        s(
        {
            trig = "preamble",
            namr = "Preamble",
            dscr = "Header text at top of new python file",
        },
        fmta([[
        #!/home/probitjk/.virtualenvs/general/bin/python3
        # -*- coding: utf-8 -*-
        """<comment>

        @date: <date>
        @author: Probit Jyoti Kalita
        """
        ]],
        {
            comment = i(1, "File Documentation"),
            date = f(date, {})
        })
        ),
    }
})
