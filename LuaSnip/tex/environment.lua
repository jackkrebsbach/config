local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local helpers = require("luasnip-helpers")

local tex_utils = helpers.tex_utils
local get_visual = helpers.get_visual

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node

return {
  s(
    { trig = "([^%a])mm", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>$<>$", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    },
      { delimiters = "<>", }
    )
  ),
  s({ trig = "al*", snippetType = "autosnippet" },
    fmta(
      [[
      \begin{align*}
          <>
      \end{align*}
    ]],
      {
        i(1),
      }
    )
  ),
  s({ trig = "env", snippetType = "autosnippet" },
    fmta(
      [[
      \begin{<>}
          <>
      \end{<>}
    ]],
      {
        i(1),
        i(2),
        rep(1), -- this node repeats insert node i(1)
      }
    )
  ),
  -- \texttt
  s({ trig = "tt", dscr = "Expands 'tt' into '\texttt{}'" },
    fmta(
      "\\texttt{<>}",
      { i(1) }
    )

  ),
  s({ trig = "df", snippetType = "autosnippet" },
    { t("\\diff") },
    { condition = tex_utils.in_mathzone }
  ),

  s({ trig = "op", snippetType = "autosnippet" },
    fmt("\\operatorname{<>}",
      { i(1) },
      { delimiters = '<>' }),
    { condition = tex_utils.in_mathzone }
  ),
  -- \frac
  s({ trig = "ff", dscr = "Expands 'ff' into '\frac{}{}'", snippetType = "autosnippet", condition = tex_utils.in_mathzone },
    fmt(
      "\\frac{<>}{<>}",
      {
        i(1),
        i(2)
      },
      { delimiters = "<>", }
    )
  ),
  s({ trig = "eq", dscr = "A LaTeX equation environment" },
    fmt(
      [[
      \begin{equation}
          <>
      \end{equation}
    ]],
      { i(1) },
      { delimiters = "<>" }
    )
  ),
  -- Greek letter snippets, autotriggered for efficiency
  s({ trig = ";a", snippetType = "autosnippet" },
    {
      t("\\alpha"),
    }
  ),
  s({ trig = ";b", snippetType = "autosnippet" },
    {
      t("\\beta"),
    }
  ),
  s({ trig = ";g", snippetType = "autosnippet" },
    {
      t("\\gamma"),
    }
  ),
}
