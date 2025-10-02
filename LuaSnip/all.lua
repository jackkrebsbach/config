local ls = require("luasnip")
local fmta = require("luasnip.extras.fmt").fmta
local helpers = require("luasnip-helpers")

local get_visual = helpers.get_visual
local line_begin_or_non_letter = helpers.line_begin_or_non_letter

local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local d = ls.dynamic_node

return
{
  -- -- Paired parentheses
  -- s({ trig = "(", wordTrig = false, snippetType = "autosnippet" },
  --   {
  --     t("("),
  --     d(1, get_visual),
  --     t(")"),
  --   }),
  -- -- Paired curly braces
  -- s({ trig = "{", wordTrig = false, snippetType = "autosnippet" },
  --   {
  --     t("{"),
  --     d(1, get_visual),
  --     t("}"),
  --   }),
  -- -- Paired square brackets
  -- s({ trig = "[", wordTrig = false, snippetType = "autosnippet" },
  --   {
  --     t("["),
  --     d(1, get_visual),
  --     t("]"),
  --   }),
  -- -- Paired back ticks
  -- s({ trig = "sf", snippetType = "autosnippet" },
  --   {
  --     f(function(_, snip) return snip.captures[1] end),
  --     t("`"),
  --     d(1, get_visual),
  --     t("`"),
  --   }),
  -- -- Paired double quotes
  -- s({ trig = '"', wordTrig = false, snippetType = "autosnippet", priority = 2000 },
  --   fmta(
  --     '"<>"',
  --     {
  --       d(1, get_visual),
  --     }
  --   ),
  --   { condition = line_begin_or_non_letter }
  -- ),
  -- -- Paired single quotes
  -- s({ trig = "'", wordTrig = false, snippetType = "autosnippet", priority = 2000 },
  --   fmta(
  --     "'<>'",
  --     {
  --       d(1, get_visual),
  --     }
  --   ),
  --   { condition = line_begin_or_non_letter }
  -- ),
  -- Curly braces
  s({ trig = "fds", snippetType = "autosnippet" },
    fmta(
      [[
        {
          <>
        }
        ]],
      { d(1, get_visual) }
    )
  ),
  -- Square braces
  s({ trig = "gds", snippetType = "autosnippet" },
    fmta(
      [[
        [
          <>
        ]
        ]],
      { d(1, get_visual) }
    )
  ),
  -- em dash
  s({ trig = "---", wordTrig = false },
    { t("—") }
  ),
  -- Lorem ipsum
  s({ trig = "lipsum" },
    fmta(
      [[
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        ]],
      {}
    )
  ),
}
