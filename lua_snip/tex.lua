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

local tex_utils = {}
tex_utils.in_mathzone = function() -- math context detection
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex_utils.in_text = function()
  return not tex_utils.in_mathzone()
end
tex_utils.in_comment = function() -- comment detection
  return vim.fn['vimtex#syntax#in_comment']() == 1
end
tex_utils.in_env = function(name) -- generic environment detection
  local is_inside = vim.fn['vimtex#env#is_inside'](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end
tex_utils.in_equation = function() -- equation environment detection
  return tex_utils.in_env('equation')
end
tex_utils.in_itemize = function() -- itemize environment detection
  return tex_utils.in_env('itemize')
end
tex_utils.in_tikz = function() -- TikZ picture environment detection
  return tex_utils.in_env('tikzpicture')
end

local get_visual = function(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else
    return sn(nil, i(1)) -- If LS_SELECT_RAW is empty, return a blank insert node
  end
end

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
