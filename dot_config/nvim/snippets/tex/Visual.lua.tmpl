-- The setting of visual operator
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
-- need to turn on store_selection_keys = "<Tab>" in luasnip config files
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
  s(
    { trig = "ti", dscr = "Expands 'tii' into LaTeX's textit{} command.", priority = 10 },
    fmta("\\textit{<>}", {
      d(1, get_visual),
    })
  ),
  s(
    { trig = "tb", dscr = "Expands 'tii' into LaTeX's textbf{} command.", priority = 10 },
    fmta("\\textit{<>}", {
      d(1, get_visual),
    })
  ),
  s(
    { trig = "emph", priority = 10, dscr = "the emph command, either in insert mode or wrapping a visual selection" },
    fmta("\\emph{<>}", { d(1, get_visual) })
  ),
  s(
    {
      trig = "U",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 10,
    },
    fmta("\\underbrace{<>}_{<>}", {
      d(1, get_visual),
      i(2),
    }),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    {
      trig = "O",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 10,
    },
    fmta("\\overbrace{<>}^{<>}", {
      d(1, get_visual), -- 获取选中的文本
      i(2), -- 插入节点，用于用户输入
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "B",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 10,
    },
    fmta("\\underset{<>}{<>}", {
      i(1), -- 插入节点
      d(2, get_visual), -- 获取选中的文本
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "C",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 10,
    },
    fmta("\\cancel{<>}", {
      d(1, get_visual), -- 获取选中的文本
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "K",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 10,
    },
    fmta("\\cancelto{<>}{<>}", {
      i(1), -- 插入节点
      d(2, get_visual), -- 获取选中的文本
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "S",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 10,
    },
    fmta("\\sqrt{<>}", {
      d(1, get_visual), -- 获取选中的文本
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "V",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 10,
    },
    fmta("\\overset{<>}{<>}", {
      i(1), -- 插入节点
      d(2, get_visual), -- 获取选中的文本
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "L",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 10,
    },
    fmta("\\overline{<>}", {
      d(1, get_visual), -- 获取选中的文本
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "box",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 10,
    },
    fmta("\\boxed{<>}", {
      d(1, get_visual), -- 获取选中的文本
    }),
    { condition = tex_utils.in_mathzone }
  ),
  -- Text color
  --
  s(
    {
      trig = "red",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 10,
    },
    fmta("\\textcolor{red}{<>}", {
      d(1, get_visual), -- 获取选中的文本
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "blue",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 10,
    },
    fmta("\\textcolor{blue}{<>}", {
      d(1, get_visual), -- 获取选中的文本
    }),
    { condition = tex_utils.in_mathzone }
  ),
  -- Braket
  --
  s(
    {
      trig = "avg",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 10,
    },
    fmta("\\langle <> \\rangle <>", {
      i(1), -- 插入节点，用于用户输入
      i(2), -- 插入节点，用于用户输入
    })
  ),

  s(
    {
      trig = "norm",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 10,
    },
    fmta("\\lvert <> \\rvert <>", {
      i(1), -- 插入节点，用于用户输入
      i(2), -- 插入节点，用于用户输入
    })
  ),

  s(
    {
      trig = "Norm",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 10,
    },
    fmta("\\lVert <> \\rVert <>", {
      i(1), -- 插入节点，用于用户输入
      i(2), -- 插入节点，用于用户输入
    })
  ),

  s(
    {
      trig = "ceil",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 10,
    },
    fmta("\\lceil <> \\rceil <>", {
      i(1), -- 插入节点，用于用户输入
      i(2), -- 插入节点，用于用户输入
    })
  ),

  s(
    {
      trig = "floor",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 10,
    },
    fmta("\\lfloor <> \\rfloor <>", {
      i(1), -- 插入节点，用于用户输入
      i(2), -- 插入节点，用于用户输入
    })
  ),

  s(
    {
      trig = "mod",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 10,
    },
    fmta("|<>|<>", {
      i(1), -- 插入节点，用于用户输入
      i(2), -- 插入节点，用于用户输入
    })
  ),
  s(
    {
      trig = "(",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 10, -- 设置优先级
    },
    fmta("(<>)", {
      d(1, get_visual), -- 获取选中的文本
    })
  ),

  s(
    {
      trig = "[",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 10, -- 设置优先级
    },
    fmta("[<>]", {
      d(1, get_visual), -- 获取选中的文本
    })
  ),

  s(
    {
      trig = "{",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 10, -- 设置优先级
    },
    fmta("{<>}", {
      d(1, get_visual), -- 获取选中的文本
    })
  ),

  s(
    {
      trig = "(",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 10, -- 设置优先级
    },
    fmta("(<>)<>", {
      i(1), -- 插入节点，用于用户输入
      i(0), -- 插入节点，用于用户输入
    })
  ),

  s(
    {
      trig = "{",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 10, -- 设置优先级
    },
    fmta("{<>}<>", {
      i(1), -- 插入节点，用于用户输入
      i(0), -- 插入节点，用于用户输入
    })
  ),

  s(
    {
      trig = "[",
      wordTrig = false,
      snippetType = "autosnippet",
      priority = 10, -- 设置优先级
    },
    fmta("[<>]<>", {
      i(1), -- 插入节点，用于用户输入
      i(0), -- 插入节点，用于用户输入
    })
  ),
  s(
    {
      trig = "lr(",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmta("\\left( <> \\right) <>", {
      i(1), -- 插入节点，用于用户输入
      i(0), -- 插入节点，用于用户输入
    })
  ),

  s(
    {
      trig = "lr{",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmta("\\left\\{ <> \\right\\} <>", {
      i(1), -- 插入节点，用于用户输入
      i(0), -- 插入节点，用于用户输入
    })
  ),

  s(
    {
      trig = "lr[",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmta("\\left[ <> \\right] <>", {
      i(1), -- 插入节点，用于用户输入
      i(0), -- 插入节点，用于用户输入
    })
  ),

  s(
    {
      trig = "lr|",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmta("\\left| <> \\right| <>", {
      i(1), -- 插入节点，用于用户输入
      i(0), -- 插入节点，用于用户输入
    })
  ),

  s(
    {
      trig = "lra",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmt("\\left< {} \\right> {}", {
      i(1), -- 插入节点，用于用户输入
      i(0), -- 插入节点，用于用户输入
    }, { delimiters = "{}" })
  ),
}
