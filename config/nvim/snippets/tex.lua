local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
local rep = require("luasnip.extras").rep
-- local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

-- recursive function to autogenerate new \item for lists
local rec_ls
rec_ls = function()
    return sn(
        nil,
        c(1, { -- Order is important, sn(...) first would cause infinite loop of expansion.
            t(""),
            sn(nil, { t({ "", "\t\\item " }), i(1, "text here"), d(2, rec_ls, {}) }),
        })
    )
end
ls.add_snippets(nil, {
    tex = {
        s(
            {
                trig = "tm",
                namr = "Inline math",
                dscr = "Inline math using \\(\\)",
            },
            {
                t("\\("), i(1), t("\\)"), i(0),
            }
        ),
        s(
            {
                trig = "tm2",
                namr = "Inline math alt",
                dscr = "Math in inline mode using $$",
            },
            {
                t("$"), i(1), t("$"), i(0)
            }
        ),
        s(
            {
                trig = "dm",
                namr = "Display math",
                dscr = "Math in display mode using \\[\\]",
            },
            {
                t({ "", "\\[", "" }),
                i(1, "Math goes here"),
                t({ "", "\\]", "" }),
                i(0)
            }
        ),
        s(
            {
                trig = "()",
                namr = "Parenthesis",
                dscr = "Self sizing parenthesis for use in math mode supplied by the physics package",
            },
            {
                t("\\pqty{"),
                i(1, "expression"),
                t("}"),
                i(0),
            }
        ),
        s(
            {
                trig = "item",
                namr = "Itemize",
                dscr = "Bullet list with proper spacing",
            },
            {
                t({ "\\begin{itemize}",
                    "\\setlength\\itemsep{-0.5em}",
                    "\\vspace{-0.5em}",
                    "\t\\item " }),
                i(1, "text here"),
                d(2, rec_ls, {}),
                t({ "", "\\end{itemize}", "" }),
                i(0),
            }
        ),
        s(
            {
                trig = "preamble",
                namr = "Preamble",
                dscr = "Basic document preamble that I use for general purpose writing",
            },
            fmta(
                [[
            \documentclass[12pt, a4paper]{article}
            \usepackage{physics}
            \usepackage{fullpage}
            \usepackage{amsfonts}
            \usepackage{bbm}
            \usepackage{hyperref}
            \usepackage{tensor}
            \usepackage{graphicx}
            \usepackage{enumitem}
            \usepackage{amssymb}
            \usepackage{gensymb}
            \usepackage{xcolor}
            \pagecolor[HTML]{1e1e2e}
            \color[HTML]{cdd6f4}
            \title{<1>}
            \author{Probit Jyoti Kalita}
            \date{\today}
            \begin{document}
            \maketitle
            <2>
            \end{document}
            ]],
                {
                    i(1, "Title of document"), i(2, "Document body")
                })
        ),
        s(
            {
                trig = "mcal",
                namr = "MathCal",
                dscr = "Cursive math font",
            },
            {
                t("\\mathcal{"), i(1, "text"), t("}"), i(0)
            }
        ),
        s(
            {
                trig = "mrm",
                namr = "Mathrm",
                dscr = "Upright math font",
            },
            {
                t("\\mathrm{"), i(1, "text"), t("}"), i(0)
            }
        ),
        s(
            {
                trig = "frac",
                namr = "Fraction",
                dscr = "Fractions in math mode",
            },
            fmta(
                [[
                \frac{<1>}{<2>}
                ]],
                {
                    i(1, "numerator"), i(2, "denominator")
                })
        ),
        s(
        {
            trig = "eq",
            namr = "Equation",
            dscr = "Begin a numbered equation",
        },
            fmta([[
            \begin{equation}
                <1>
            \label{eq:<2>}
            \end{equation}
            ]],
            {
                i(1, "equation"), i(2, "equation number")
            })
        ),
        s(
        {
            trig = "align",
            namr = "Aligned equations",
            dscr = "Create a numbered/non-numbered aligned environment",
        },
        fmta([[
        \begin{<>}
            <>
        \label{eq:<>}
        \end{<>}
        ]],
        {
            c(1, {t("align"), t("align*")}),
            i(2, "Equations"),
            i(3, "Equation number"),
            rep(1)
        })
        ),
        s(
        {
            trig = "sum",
            namr = "Summation",
            dscr = "Summation symbol with option of summation index at bottom",
        },
        {
            t("\\sum"),
            c(1,
            {
                t(" "),
                sn(nil, { t("_{"), i(1, "summation index"), t("}") }),
            })
        }
        ),
        s(
        {
            trig = "suml",
            namr = "Summation_limits",
            dscr = "Summation with limits",
        },
        {
            t("\\sum\\limits_{"), i(1, "from"), t("^"), i(2, "to"), t("}")
        }
        ),
        s(
        {
            trig = "bold",
            namr = "Bold text",
            dscr = "Write bold text",
        },
        {
            t("\\textbf{"), i(1, "text"), t("}"), i(0)
        }
        ),
        s(
        {
            trig = "ital",
            namr = "Italics",
            dscr = "Italicise text",
        },
        {
            t("\\textit{"), i(1, "text"), t("}"), i(0)
        }
        ),
        s(
        {
            trig = "vu",
            namr = "Unit vector",
            dscr = "Vector with hat on top provided by the physics package",
        },
        {
            t("\\vu{"), i(1), t("}"), i(0)
        }
        ),
        s(
        {
            trig = "va",
            namr = "Vector",
            dscr = "Vector with arrow on top provided by the physics package",
        },
        {
            t("\\va{"), i(1), t("}"), i(0)
        }
        ),
        s(
        {
            trig = "vb",
            namr = "Vector bold",
            dscr = "Vector in bold provided by the physics package",
        },
        {
            t("\\vb{"), i(1), t("}"), i(0)
        }
        ),
    },
})
