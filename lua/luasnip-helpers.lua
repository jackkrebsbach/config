local M = {}

local ls = require("luasnip")
local sn = ls.snippet_node
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local d = ls.dynamic_node

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

M.tex_utils = tex_utils

function M.get_visual(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else
    return sn(nil, i(1, ''))
  end
end

function M.line_begin_or_non_letter(line_to_cursor, matched_trigger)
  local line_begin = line_to_cursor:sub(1, -(#matched_trigger + 1)):match("^%s*$")
  local non_letter = line_to_cursor:sub( -(#matched_trigger + 1), -(#matched_trigger + 1)):match('[ :`=%{%(%["]')
  return line_begin or non_letter
end

return M
