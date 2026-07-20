-- ────────────────────────────────────────────────────────────────────
-- Dracula theme for .tex windows only.
--
-- Highlight groups in Neovim are global, so to recolor JUST tex buffers
-- every override lives in a private highlight namespace that is attached
-- to windows showing a tex buffer. Every other window keeps the global
-- carbonfox colorscheme untouched.
--
-- Background/text/current-line sampled from the reference screenshot
-- (Dracula palette).
-- ────────────────────────────────────────────────────────────────────

local dracula = {
  bg      = "#282a36", -- background
  fg      = "#f8f8f2", -- text
  line    = "#44475a", -- visual selection
  cursor  = "#343746", -- current line (lighter than bg, subtler than selection)
  comment = "#6272a4",
  orange  = "#ffb86c",
  pink    = "#ff79c6",
  purple  = "#bd93f9", -- \section \begin \item \textbf ("blue")
  yellow  = "#f1fa8c",
}

local tex_ns = vim.api.nvim_create_namespace("tex_dracula")

local function define_tex_highlights()
  local d = dracula
  local set = function(group, opts) vim.api.nvim_set_hl(tex_ns, group, opts) end

  -- Editing surface
  set("Normal",         { fg = d.fg, bg = d.bg })
  set("NormalNC",       { fg = d.fg, bg = d.bg })
  set("SignColumn",     { bg = d.bg })
  set("EndOfBuffer",    { fg = d.bg, bg = d.bg })
  set("LineNr",         { fg = d.comment, bg = d.bg })
  set("CursorLine",     { bg = d.cursor })
  set("CursorLineNr",   { fg = d.fg, bg = d.cursor, bold = true })
  set("Visual",         { bg = d.line })
  set("MatchParen",     { fg = d.pink, bg = d.line, bold = true })
  set("Comment",        { fg = d.comment, italic = true })

  -- Treesitter (LaTeX) — mapped to match the screenshot
  set("@comment",               { fg = d.comment, italic = true })
  set("@function",              { fg = d.pink })                  -- \command
  set("@function.macro",        { fg = d.pink })
  set("@keyword.import",        { fg = d.pink })                  -- \begin \end \usepackage
  set("@keyword.conditional",   { fg = d.pink })
  set("@keyword.directive",     { fg = d.pink })
  set("@operator",              { fg = d.pink })
  set("@punctuation.special",   { fg = d.pink })
  set("@module",                { fg = d.orange, italic = true }) -- environment names {itemize}
  set("@label",                 { fg = d.orange, italic = true }) -- \ref / \label keys
  set("@markup.link",           { fg = d.orange, italic = true })
  set("@markup.link.url",       { fg = d.orange, underline = true })
  set("@string.special.path",   { fg = d.orange })
  set("@markup.math",           { fg = d.yellow })                -- $ ... $  and \[ \]
  set("@string",                { fg = d.yellow })
  set("@string.regexp",         { fg = d.yellow })
  set("@markup.heading",        { fg = d.fg })
  set("@variable",              { fg = d.fg })
  set("@variable.parameter",    { fg = d.orange, italic = true })
  set("@punctuation.bracket",   { fg = d.fg })
  set("@punctuation.delimiter", { fg = d.fg })
  set("@markup.italic",         { italic = true })
  set("@markup.strong",         { bold = true })

  -- VimTeX regex groups (additional_vim_regex_highlighting is enabled).
  -- Note: LaTeX commands are colored by these groups, not by treesitter.
  -- General/math commands (\hat \mathbf \ref \pm ...) stay pink:
  set("texCmd",        { fg = d.pink })
  set("texCmdRef",     { fg = d.pink })
  set("texMathOper",   { fg = d.pink })
  set("texMathSymbol", { fg = d.pink })
  -- Structural / text-formatting commands are purple ("blue"):
  set("texCmdPart",       { fg = d.purple }) -- \section \subsection ...
  set("texCmdEnv",        { fg = d.purple }) -- \begin \end
  set("texCmdItem",       { fg = d.purple }) -- \item  (overrides its link to texCmd)
  set("texCmdStyle",      { fg = d.purple })
  set("texCmdStyleBold",  { fg = d.purple }) -- \textbf
  set("texCmdStyleItal",  { fg = d.purple }) -- \textit
  set("texCmdStyleBoth",  { fg = d.purple }) -- \emph
  -- Arguments / math / structure:
  set("texEnvArgName", { fg = d.orange, italic = true }) -- {itemize}
  set("texRefArg",     { fg = d.orange, italic = true })
  set("texFileArg",    { fg = d.orange })
  set("texMathZone",   { fg = d.yellow })
  set("texMathZoneX",  { fg = d.yellow })
  set("texMathDelim",  { fg = d.yellow })
  set("texComment",    { fg = d.comment, italic = true })
  set("texDelim",      { fg = d.fg })
end

define_tex_highlights()

local tex_group = vim.api.nvim_create_augroup("tex-dracula", { clear = true })

-- Colorscheme switches reset highlights; redefine ours afterwards.
vim.api.nvim_create_autocmd("ColorScheme", {
  group = tex_group,
  callback = define_tex_highlights,
})

-- True when a quickfix/location window points at a tex file (e.g. the
-- VimTeX compile log), so it should share the tex theme. Other quickfix
-- lists (LSP references, grep in non-tex files) are left untouched.
local function qf_is_tex(win)
  local info = vim.fn.getwininfo(win)[1]
  if not info then return false end
  local list = info.loclist == 1 and vim.fn.getloclist(win) or vim.fn.getqflist()
  for _, item in ipairs(list) do
    local b = item.bufnr
    if b and b > 0 then
      if vim.bo[b].filetype == "tex" or vim.api.nvim_buf_get_name(b):match("%.tex$") then
        return true
      end
    end
  end
  return false
end

local function window_wants_dracula(win, buf)
  local ft = vim.bo[buf].filetype
  return ft == "tex" or (ft == "qf" and qf_is_tex(win))
end

-- Attach the namespace to tex windows (and the VimTeX quickfix); restore
-- the default namespace (0) for every other buffer so the theme cannot
-- leak when a window switches to a non-tex file. The current-line
-- highlight (cursorline) is enabled only for tex windows for the same
-- reason.
vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter", "FileType", "WinEnter" }, {
  group = tex_group,
  callback = function(args)
    for _, win in ipairs(vim.fn.win_findbuf(args.buf)) do
      local wants = window_wants_dracula(win, args.buf)
      pcall(vim.api.nvim_win_set_hl_ns, win, wants and tex_ns or 0)
      pcall(vim.api.nvim_set_option_value, "cursorline", wants, { win = win })
    end
  end,
})
