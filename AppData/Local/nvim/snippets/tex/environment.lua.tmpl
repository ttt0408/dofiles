-- The setting of various enviroment
--
local tex_utils = {}
tex_utils.in_mathzone = function() -- math context detection
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
tex_utils.in_text = function()
  return not tex_utils.in_mathzone()
end
tex_utils.in_comment = function() -- comment detection
  return vim.fn["vimtex#syntax#in_comment"]() == 1
end
tex_utils.in_env = function(name) -- generic environment detection
  local is_inside = vim.fn["vimtex#env#is_inside"](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
tex_utils.in_equation = function() -- equation environment detection
  return tex_utils.in_env("equation")
end
tex_utils.in_itemize = function() -- itemize environment detection
  return tex_utils.in_env("itemize")
end
tex_utils.in_tikz = function() -- TikZ picture environment detection
  return tex_utils.in_env("tikzpicture")
end

-- Visual choose word
local get_visual = function(args, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

local line_begin = require("luasnip.extras.expand_conditions").line_begin
-- NOTE: Not in use local line_end = require("luasnip.extras.expand_conditions").line_end
local cond_obj = require("luasnip.extras.conditions")

--- @param pattern string valid lua pattern
local function make_trigger_does_not_follow_char(pattern)
  local condition = function(line_to_cursor, matched_trigger)
    local line_to_trigger_len = #line_to_cursor - #matched_trigger
    if line_to_trigger_len == 0 then
      return true
    end
    return not string.sub(line_to_cursor, line_to_trigger_len, line_to_trigger_len):match(pattern)
  end
  return cond_obj.make_condition(condition)
end

local trigger_does_not_follow_alpha_num_char = make_trigger_does_not_follow_char("%w")
local trigger_does_not_follow_alpha_char = make_trigger_does_not_follow_char("%a")

-- config the enviroment
--
return {
  s({
    trig = "mk",
    wordTrig = true,
    snippetType = "autosnippet",
  }, fmta("$<>$", { i(1) }), { condition = not tex_utils.in_mathzone }),
  s({
    trig = "dm",
    wordTrig = true,
    snippetType = "autosnippet",
  }, fmta("$$<>$$", { i(1) }), { condition = not tex_utils.in_mathzone }),
  s(
    {
      trig = "bg",
      wordTrig = true,
      -- snippetType = "autosnippet",
      priority = 100,
    },
    fmta(
      [[ 
      \begin{<>}
      <>
      \end{<>}
      ]],
      { i(1), i(2), rep(1) }
    )
  ),
  s(
    { trig = "eq", wordTrig = true, priority = 50, dscr = "Expands 'eq' into an equation environment" },
    fmta(
      [[
        \begin{equation}
            <>
        \end{equation}
      ]],
      { i(1) }
    )
  ),
  s(
    {
      trig = "bgad",
      wordTrig = true,
      snippetType = "autosnippet",
      priority = 100,
    },
    fmta(
      [[ 
      \begin{aligned}
      <>
      \end{aligned}
      ]],
      { i(1) }
    ),
    { condition = not tex_utils.in_mathzone }
  ),
  s(
    {
      trig = "bggd",
      wordTrig = true,
      snippetType = "autosnippet",
      priority = 100,
    },
    fmta(
      [[
      \begin{gathered}
      <>
      \end{gathered}
      ]],
      { i(1) }
    ),
    { condition = tex_utils.in_mathzone }
  ),
  s({
    trig = "\\t",
    wordTrig = true,
    --regTrig = true,
    snippetType = "autosnippet",
  }, fmta("\\text{<>}", { i(1) }), { condition = tex_utils.in_mathzone }),
  s(
    {
      trig = "\\([%d])",
      wordTrig = true,
      regTrig = true,
      snippetType = "autosnippet",
    },
    fmta("\\hspace{ <> em}", { f(function(_, snip)
      return snip.captures[1]
    end) }),
    { condition = tex_utils.in_mathzone }
  ),
}
