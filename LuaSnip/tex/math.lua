local ls = require("luasnip")
local fmta = require("luasnip.extras.fmt").fmta
local helpers = require("luasnip-helpers")

local tex = helpers.tex_utils
local get_visual = helpers.get_visual

local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node

return {
  -- SUPERSCRIPT
  s({ trig = "([%w%)%]%}])'", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta(
      "<>^{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        d(1, get_visual),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- SUBSCRIPT
  s({ trig = "([%w%)%]%}]);", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta(
      "<>_{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        d(1, get_visual),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- INTEGRAL with upper and lower limit
  s({ trig = "([^%a])intt", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta(
      "<>\\int_{<>}^{<>}",
      {
        f(function(_, snip) return snip.captures[1] end),
        i(1),
        i(2),
      }
    ),
    { condition = tex.in_mathzone }
  ),
  -- INTEGRAL from positive to negative infinity
  s({ trig = "([^%a])intf", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta(
      "<>\\int_{\\infty}^{\\infty}",
      {
        f(function(_, snip) return snip.captures[1] end),
      }
    ),
    { condition = tex.in_mathzone }
  ),

}
