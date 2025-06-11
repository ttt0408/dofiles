-- The setting of script
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

--some variable
local SB =
  "parallel|perp|partial|nabla|hbar|ell|infty|oplus|ominus|otimes|oslash|square|star|dagger|vee|wedge|subseteq|subset|supseteq|supset|emptyset|exists|nexists|forall|implies|impliedby|iff|setminus|neg|lor|land|bigcup|bigcap|cdot|times|simeq|approx"
local MSB =
  "leq|geq|neq|gg|ll|equiv|sim|propto|rightarrow|leftarrow|Rightarrow|Leftarrow|leftrightarrow|to|mapsto|cap|cup|in|sum|prod|exp|ln|log|det|dots|vdots|ddots|pm|mp|int|iint|iiint|oint"

local trigger_does_not_follow_alpha_num_char = make_trigger_does_not_follow_char("%w")
local trigger_does_not_follow_alpha_char = make_trigger_does_not_follow_char("%a")

return {
  -- Basic operations in math input
  --
  s(
    {
      trig = "h([%d])",
      wordTrig = false,
      regTrig = true,
      snippetType = "autosnippet",
      priority = 50,
    },
    fmta("^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = tex_utils.in_mathzone }
  ),
  s({
    trig = "hf",
    wordTrig = false,
    regTrig = true,
    snippetType = "autosnippet",
  }, fmta("^{<>}", { i(1) }), { condition = tex_utils.in_mathzone }),

  s({
    trig = "h'",
    wordTrig = false,
    regTrig = true,
    snippetType = "autosnippet",
  }, t("^{\\prime}"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "lf",
    wordTrig = false,
    regTrig = true,
    snippetType = "autosnippet",
  }, fmta("_{<>}", { i(1) }), { condition = tex_utils.in_mathzone }),

  s({
    trig = "sq",
    wordTrig = false,
    regTrig = true,
    snippetType = "autosnippet",
  }, fmta("\\sqrt{<>}", { i(1) }), { condition = tex_utils.in_mathzone }),

  s({
    trig = "//",
    wordTrig = false,
    regTrig = true,
    snippetType = "autosnippet",
  }, fmta("\\frac{<>}{<>}", { i(1), i(2) }), { condition = tex_utils.in_mathzone }),

  s({
    trig = "eh",
    wordTrig = false,
    regTrig = true,
    snippetType = "autosnippet",
  }, fmta("e^{<>}", { i(1) }), { condition = tex_utils.in_mathzone }),

  s(
    {
      trig = "([A-Za-z])([%d])",
      wordTrig = false,
      regTrig = true,
      snippetType = "autosnippet",
      priority = 10,
    },
    fmta("<>^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    }),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    {
      trig = "([A-Za-z])\\\\(" .. GREEK .. ")\\s",
      wordTrig = false,
      regTrig = true,
      trigEngine = "ecma",
      snippetType = "autosnippet",
      priority = 1,
    },
    fmta("<>_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    }),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    {
      trig = "([A-Za-z])h\\\\(" .. GREEK .. ")\\s",
      wordTrig = false,
      regTrig = true,
      trigEngine = "ecma",
      snippetType = "autosnippet",
      priority = 10,
    },
    fmta("<>^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    }),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    {
      trig = "([A-Za-z]\\})\\\\(" .. GREEK .. ")\\s",
      wordTrig = false,
      regTrig = true,
      trigEngine = "ecma",
      snippetType = "autosnippet",
      priority = 50,
    },
    fmta("<>_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    }),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    {
      trig = "([A-Za-z]\\})h\\\\(" .. GREEK .. ")\\s",
      wordTrig = false,
      regTrig = true,
      trigEngine = "ecma",
      snippetType = "autosnippet",
      priority = 50,
    },
    fmta("<>^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    }),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    {
      trig = "([^\\\\])(exp|log|ln)",
      regTrig = true,
      trigEngine = "ecma",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmt("{}\\{}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s({
    trig = "conj",
    wordTrig = true,
    snippetType = "autosnippet",
  }, t("^{*}"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "Re",
    wordTrig = true,
    snippetType = "autosnippet",
  }, t("\\mathrm{Re}"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "Im",
    wordTrig = true,
    snippetType = "autosnippet",
  }, t("\\mathrm{Im}"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "bf",
    wordTrig = true,
    snippetType = "autosnippet",
    priority = 50,
  }, { t("\\mathbf{"), i(1), t("}") }, { condition = tex_utils.in_mathzone }),

  s({
    trig = "rm",
    wordTrig = true,
    snippetType = "autosnippet",
    priority = 50,
  }, { t("\\mathrm{"), i(1), t("}") }, { condition = tex_utils.in_mathzone }),
  -- More auto letter subscript
  --
  s({
    trig = "\\xnn",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("x_{n}"), { condition = tex_utils.in_mathzone }),
  s({
    trig = "\\xii",
    wordTrig = false,
    snippetType = "autosnippet",
    priority = 1,
  }, t("x_{i}"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "xjj",
    wordTrig = true,
    snippetType = "autosnippet",
  }, t("x_{j}"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "xp1",
    wordTrig = true,
    snippetType = "autosnippet",
  }, t("x_{n+1}"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "ynn",
    wordTrig = true,
    snippetType = "autosnippet",
  }, t("y_{n}"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "yii",
    wordTrig = true,
    snippetType = "autosnippet",
  }, t("y_{i}"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "yjj",
    wordTrig = true,
    snippetType = "autosnippet",
  }, t("y_{j}"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "ann",
    wordTrig = true,
    snippetType = "autosnippet",
  }, t("a_{n}"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "aii",
    wordTrig = true,
    snippetType = "autosnippet",
  }, t("a_{i}"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "ajj",
    wordTrig = true,
    snippetType = "autosnippet",
  }, t("a_{j}"), { condition = tex_utils.in_mathzone }),
  s(
    {
      trig = "\\\\hat{([A-Za-z])}([%d])",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmta("\\\\hat{<>}_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    }),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    {
      trig = "\\\\vec{([A-Za-z])}([%d])",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmta("\\\\vec{<>}_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    }),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    {
      trig = "\\\\mathbf{([A-Za-z])}([%d])",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmta("\\\\mathbf{<>}_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    }),
    { condition = tex_utils.in_mathzone }
  ),
  -- more operations correction
  s(
    {
      trig = "([a-zA-Z])hat",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 50,
    },
    fmta("\\hat{<>}", { f(function(_, snip)
      return snip.captures[1]
    end) }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "([a-zA-Z])bar",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 50,
    },
    fmta("\\bar{<>}", { f(function(_, snip)
      return snip.captures[1]
    end) }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "([a-zA-Z])h\\.",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 40,
    },
    fmta("\\dot{<>}", { f(function(_, snip)
      return snip.captures[1]
    end) }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "([a-zA-Z])ht\\.",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 50,
    },
    fmta("\\ddot{<>}", { f(function(_, snip)
      return snip.captures[1]
    end) }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "([a-zA-Z])tilde",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 50,
    },
    fmta("\\tilde{<>}", { f(function(_, snip)
      return snip.captures[1]
    end) }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "([a-zA-Z]);ul",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 50,
    },
    fmta("\\underline{<>}", { f(function(_, snip)
      return snip.captures[1]
    end) }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "([a-zA-Z]);us",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 50,
    },
    fmta("\\underset{$0}{<>}", { f(function(_, snip)
      return snip.captures[1]
    end) }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "([a-zA-Z])vec",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 50,
    },
    fmta("\\vec{<>}", { f(function(_, snip)
      return snip.captures[1]
    end) }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "([a-zA-Z])rm",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 50,
    },
    fmta("\\mathrm{<>}", { f(function(_, snip)
      return snip.captures[1]
    end) }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "([a-zA-Z])bf",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 50,
    },
    fmta("\\mathbf{<>}", { f(function(_, snip)
      return snip.captures[1]
    end) }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "([a-zA-Z])cal",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 50,
    },
    fmta("\\mathcal{<>}", { f(function(_, snip)
      return snip.captures[1]
    end) }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "([a-zA-Z])scr",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 50,
    },
    fmta("\\mathscr{<>}", { f(function(_, snip)
      return snip.captures[1]
    end) }),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    {
      trig = "([a-zA-Z]),\\.",
      regTrig = true,
      trigEngine = "ecma",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 10,
    },
    fmta("\\mathbf{<>}", { f(function(_, snip)
      return snip.captures[1]
    end) }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "([a-zA-Z])\\.,",
      regTrig = true,
      trigEngine = "ecma",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 10,
    },
    fmta("\\mathbf{<>}", { f(function(_, snip)
      return snip.captures[1]
    end) }),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    {
      trig = "\\\\(" .. GREEK .. "),\\.",
      regTrig = true,
      trigEngine = "ecma",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 50,
    },
    fmta("\\bodysymbol{<>}", { f(function(_, snip)
      return snip.captures[1]
    end) }),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    {
      trig = "\\\\(" .. GREEK .. ")\\.,",
      regTrig = true,
      trigEngine = "ecma",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 50,
    },
    fmta("\\bodysymbol{<>}", { f(function(_, snip)
      return snip.captures[1]
    end) }),
    { condition = tex_utils.in_mathzone }
  ),
  s({
    trig = "ol",
    wordTrig = false,
    snippetType = "autosnippet",
  }, fmta("\\overline{<>}", i(1)), { condition = tex_utils.in_mathzone }),

  s({
    trig = "hat",
    wordTrig = false,
    snippetType = "autosnippet",
    priority = 30,
  }, fmta("\\hat{<>}", i(1)), { condition = tex_utils.in_mathzone }),

  s({
    trig = "bar",
    wordTrig = false,
    snippetType = "autosnippet",
    priority = 30,
  }, fmta("\\bar{<>}", i(1)), { condition = tex_utils.in_mathzone }),

  -- s(
  --     {
  --         trig = "h\\.",
  --         wordTrig = false,
  --         snippetType = "autosnippet",
  --         priority = 1,
  --     },
  --     fmta("\\dot{<>}", i(1)),
  --     { condition = tex_utils.in_mathzone }
  -- ),

  -- s(
  --     {
  --         trig = "ht\\.",
  --         wordTrig = false,
  --         snippetType = "autosnippet",
  --     },
  --     fmta("\\ddot{<>}", i(1)),
  --     { condition = tex_utils.in_mathzone }
  -- ),

  s({
    trig = "c.",
    wordTrig = false,
    snippetType = "autosnippet",
    priority = 30,
  }, t("\\cdot"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "tilde",
    wordTrig = false,
    snippetType = "autosnippet",
    priority = 30,
  }, fmta("\\tilde{<>}", i(1)), { condition = tex_utils.in_mathzone }),

  s({
    trig = ";ul",
    wordTrig = false,
    priority = 30,
    snippetType = "autosnippet",
  }, fmta("\\underline{<>}", i(1)), { condition = tex_utils.in_mathzone }),

  s({
    trig = ";us",
    wordTrig = false,
    priority = 30,
    snippetType = "autosnippet",
  }, fmta("\\underset{<>}{<>}", { i(1), i(2) }), { condition = tex_utils.in_mathzone }),

  s({
    trig = "vec",
    wordTrig = false,
    snippetType = "autosnippet",
    priority = 30,
  }, fmta("\\vec{<>}", i(1)), { condition = tex_utils.in_mathzone }),

  -- some script on GREEK
  --
  s(
    {
      trig = "([^\\\\])(" .. GREEK .. ")",
      wordTrig = false,
      regTrig = true,
      trigEngine = "ecma",
      snippetType = "autosnippet",
    },
    fmta("<>\\<>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    }),
    { condition = tex_utils.in_mathzone }
  ),
  -- Insert space after Greek letters and symbols
  --
  s(
    {
      trig = "\\\\(" .. GREEK .. "|" .. SB .. "|" .. MSB .. ")([A-Za-z])",
      wordTrig = false,
      regTrig = true,
      trigEngine = "ecma",
      snippetType = "autosnippet",
      priority = 120,
    },
    fmta("\\<> <>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    }),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    {
      trig = "\\\\(" .. GREEK .. ") h2",
      wordTrig = false,
      regTrig = true,
      trigEngine = "ecma",
      snippetType = "autosnippet",
      priority = 100,
    },
    fmta("\\<>^{2}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "\\\\(" .. GREEK .. ") h3",
      wordTrig = false,
      regTrig = true,
      trigEngine = "ecma",
      snippetType = "autosnippet",
      priority = 100,
    },
    fmta("\\<>^{3}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "\\\\(" .. GREEK .. ") hf",
      wordTrig = false,
      regTrig = true,
      trigEngine = "ecma",
      snippetType = "autosnippet",
      priority = 100,
    },
    fmta("\\<>^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1), -- 插入节点用于输入上标内容
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "\\\\(" .. GREEK .. ") hat",
      wordTrig = false,
      regTrig = true,
      trigEngine = "ecma",
      snippetType = "autosnippet",
      priority = 100,
    },
    fmta("\\hat{\\<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "\\\\(" .. GREEK .. ") h\\.",
      wordTrig = false,
      regTrig = true,
      trigEngine = "ecma",
      snippetType = "autosnippet",
      priority = 100,
    },
    fmta("\\dot{\\<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "\\\\(" .. GREEK .. ") bar",
      wordTrig = false,
      regTrig = true,
      trigEngine = "ecma",
      snippetType = "autosnippet",
      priority = 100,
    },
    fmta("\\bar{\\<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "\\\\(" .. GREEK .. ") vec",
      wordTrig = false,
      regTrig = true,
      trigEngine = "ecma",
      snippetType = "autosnippet",
      priority = 100,
    },
    fmta("\\vec{\\<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "\\\\(" .. GREEK .. ") tilde",
      wordTrig = false,
      regTrig = true,
      trigEngine = "ecma",
      snippetType = "autosnippet",
      priority = 100,
    },
    fmta("\\tilde{\\<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "\\\\(" .. GREEK .. ");ul",
      wordTrig = false,
      regTrig = true,
      trigEngine = "ecma",
      snippetType = "autosnippet",
      priority = 100,
    },
    fmta("\\underline{\\<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = tex_utils.in_mathzone }
  ),
}
