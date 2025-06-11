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
-- the snippets of some signatures
--
-- GREEK latter
return {
  s({
    trig = "aa",
    wordTrig = false,
    snippetType = "autosnippet",
  }, {
    t("\\alpha"),
  }, { condition = tex_utils.in_mathzone }),
  s({
    trig = "bb",
    wordTrig = false,
    snippetType = "autosnippet",
  }, {
    t("\\beta"),
  }, { condition = tex_utils.in_mathzone }),

  s({
    trig = "gg",
    wordTrig = true,
    snippetType = "autosnippet",
    priority = 10,
  }, {
    t("\\gamma"),
  }, { condition = tex_utils.in_mathzone }),

  s({
    trig = "GG",
    wordTrig = true,
    snippetType = "autosnippet",
    priority = 10,
  }, {
    t("\\Gamma"),
  }, { condition = tex_utils.in_mathzone }),

  s({
    trig = ";dd",
    wordTrig = false,
    snippetType = "autosnippet",
  }, {
    t("\\delta"),
  }, { condition = tex_utils.in_mathzone }),

  s({
    trig = ";DD",
    wordTrig = false,
    snippetType = "autosnippet",
  }, {
    t("\\Delta"),
  }, { condition = tex_utils.in_mathzone }),

  s({
    trig = "ee",
    wordTrig = false,
    snippetType = "autosnippet",
  }, {
    t("\\epsilon"),
  }, { condition = tex_utils.in_mathzone }),

  s({
    trig = ";e",
    wordTrig = false,
    snippetType = "autosnippet",
  }, {
    t("\\varepsilon"),
  }, { condition = tex_utils.in_mathzone }),

  s({
    trig = "zz",
    wordTrig = false,
    snippetType = "autosnippet",
  }, {
    t("\\zeta"),
  }, { condition = tex_utils.in_mathzone }),

  s({
    trig = "tt",
    wordTrig = false,
    snippetType = "autosnippet",
  }, {
    t("\\theta"),
  }, { condition = tex_utils.in_mathzone }),

  s({
    trig = "TT",
    wordTrig = false,
    snippetType = "autosnippet",
  }, {
    t("\\Theta"),
  }, { condition = tex_utils.in_mathzone }),

  s({
    trig = ";t",
    wordTrig = false,
    snippetType = "autosnippet",
  }, {
    t("\\vartheta"),
  }, { condition = tex_utils.in_mathzone }),

  -- s(
  --   {
  --     trig = "ii",
  --     wordTrig = false,
  --     snippetType = "autosnippet",
  --   },
  --   {
  --     t("\\iota")
  --   },
  --   { condition = tex_utils.in_mathzone }
  -- ),

  s({
    trig = "kk",
    wordTrig = false,
    snippetType = "autosnippet",
  }, {
    t("\\kappa"),
  }, { condition = tex_utils.in_mathzone }),

  s({
    trig = ";ll",
    wordTrig = false,
    snippetType = "autosnippet",
  }, {
    t("\\lambda"),
  }, { condition = tex_utils.in_mathzone }),

  s({
    trig = ";LL",
    wordTrig = false,
    snippetType = "autosnippet",
  }, {
    t("\\Lambda"),
  }, { condition = tex_utils.in_mathzone }),

  s({
    trig = "ss",
    wordTrig = false,
    snippetType = "autosnippet",
  }, {
    t("\\sigma"),
  }, { condition = tex_utils.in_mathzone }),

  s({
    trig = "SS",
    wordTrig = false,
    snippetType = "autosnippet",
  }, {
    t("\\Sigma"),
  }, { condition = tex_utils.in_mathzone }),

  s({
    trig = "us",
    wordTrig = false,
    priority = 10,
    snippetType = "autosnippet",
  }, {
    t("\\upsilon"),
  }, { condition = tex_utils.in_mathzone }),

  s({
    trig = "Us",
    wordTrig = false,
    priority = 10,
    snippetType = "autosnippet",
  }, {
    t("\\Upsilon"),
  }, { condition = tex_utils.in_mathzone }),

  s({
    trig = "ome",
    wordTrig = false,
    snippetType = "autosnippet",
  }, {
    t("\\omega"),
  }, { condition = tex_utils.in_mathzone }),

  s({
    trig = "Ome",
    wordTrig = false,
    snippetType = "autosnippet",
  }, {
    t("\\Omega"),
  }, { condition = tex_utils.in_mathzone }),
  -- physics signatures
  s({
    trig = "st",
    wordTrig = false,
    snippetType = "autosnippet",
  }, fmta("|<>\\rangle", { i(1) }), { condition = tex_utils.in_mathzone }),

  s({
    trig = "dst",
    wordTrig = false,
    snippetType = "autosnippet",
  }, fmta("\\langle<>\\|<>", { i(1), i(2) }), { condition = tex_utils.in_mathzone }),

  s({
    trig = "ehi",
    wordTrig = false,
    snippetType = "autosnippet",
  }, fmta("e^{-\\mathrm{i}<>}<>", { i(1), i(0) }), { condition = tex_utils.in_mathzone }),

  s({
    trig = "dag",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("^{\\dagger}"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "os",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\oplus "), { condition = tex_utils.in_mathzone }),

  s({
    trig = "ot",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\otimes "), { condition = tex_utils.in_mathzone }),

  s({
    trig = "bra",
    wordTrig = false,
    snippetType = "autosnippet",
  }, fmta("\\bra{<>} <>", { i(1), i(0) }), { condition = tex_utils.in_mathzone }),

  s({
    trig = "ket",
    wordTrig = false,
    snippetType = "autosnippet",
  }, fmta("\\ket{<>} <>", { i(1), i(0) }), { condition = tex_utils.in_mathzone }),

  s({
    trig = "brk",
    wordTrig = false,
    snippetType = "autosnippet",
  }, fmta("\\braket{<> | <>} <>", { i(1), i(2), i(0) }), { condition = tex_utils.in_mathzone }),

  s({
    trig = "psi",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\psi"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "vfi",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\varphi"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "vFi",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\varPhi"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "Psi",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\Psi"), { condition = tex_utils.in_mathzone }),

  s({
    trig = ";pa",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\partial"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "outer",
    wordTrig = false,
    snippetType = "autosnippet",
  }, fmta("\\ket{<>} \\bra{<>} <>", { i(1), i(2), i(0) }), { condition = tex_utils.in_mathzone }),

  s({
    trig = ";ua",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\uparrow"), { condition = tex_utils.in_mathzone }),

  s({
    trig = ";da",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\downarrow"), { condition = tex_utils.in_mathzone }),

  s({
    trig = ";ra",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\rightarrow"), { condition = tex_utils.in_mathzone }),

  s({
    trig = ";la",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\leftarrow"), { condition = tex_utils.in_mathzone }),

  s({
    trig = ";Ra",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\rightarrow"), { condition = tex_utils.in_mathzone }),

  s({
    trig = ";La",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\leftarrow"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "HH",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\mathcal{H}"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "LL",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\mathcal{L}"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "box",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\Box"), { condition = tex_utils.in_mathzone }),
  -- Linear algebra
  s(
    {
      trig = "([^\\\\])(det)",
      regTrig = true,
      trigEngine = "ecma",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmt("{}\\det{}", {
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
    trig = "tr",
    wordTrig = true,
    snippetType = "autosnippet",
  }, t("\\mathrm{Tr}"), { condition = tex_utils.in_mathzone }),
  --Symbols
  --
  s({
    trig = "ooo",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\infty"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "sum",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\sum"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "prod",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\prod"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "\\sum%s",
    regTrig = true,
    wordTrig = false,
    snippetType = "autosnippet",
  }, fmta("\\sum_{<>=<>}^{<>} ", { i(1, "i"), i(2, "1"), i(3, "N") }), { condition = tex_utils.in_mathzone }),

  s({
    trig = "\\prod%s",
    wordTrig = false,
    regTrig = true,
    snippetType = "autosnippet",
  }, fmta("\\prod_{<>=<>}^{<>} ", { i(1, "i"), i(2, "1"), i(3, "N") }), { condition = tex_utils.in_mathzone }),

  s({
    trig = "lim",
    wordTrig = false,
    snippetType = "autosnippet",
  }, fmta("\\lim_{<> \\to <>} ", { i(1, "n"), i(2, "\\infty") }), { condition = tex_utils.in_mathzone }),

  s({
    trig = ";pm",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\pm"), { condition = tex_utils.in_mathzone }),

  s({
    trig = ";mp",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\mp"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "...",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\dots"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "nal",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\nabla"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "xx",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\times"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "**",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\cdot"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "para",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\parallel"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "===",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\equiv"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "!=",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\neq"), { condition = tex_utils.in_mathzone }),

  s({
    trig = ">=",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\geq"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "<=",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\leq"), { condition = tex_utils.in_mathzone }),

  s({
    trig = ">>",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\gg"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "<<",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\ll"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "simm",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\sim"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "sim=",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\simeq"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "ap=",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\approx"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "prop",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\propto"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "cong",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\cong"), { condition = tex_utils.in_mathzone }),

  s(
    {
      trig = "<->",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    t("\\rightarrow  "), -- 如果需要特定替换请调整
    { condition = tex_utils.in_mathzone }
  ),

  s({
    trig = "->",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\to"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "!>",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\mapsto"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "=>",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\implies"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "=<",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\impliedby"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "and",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\cap"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "orr",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\cup"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "inn",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\in"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "notin",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\not\\in"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "\\\\\\",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\setminus"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "sub=",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\subseteq"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "sup=",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\supseteq"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "eset",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\emptyset"), { condition = tex_utils.in_mathzone }),

  s(
    {
      trig = "set",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmta("\\{ <> \\} ", { i(1) }), -- 使用插入节点
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "lg=",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmta("\\xlongequal[<>]{<>}", { i(1), i(2) }), -- 使用插入节点
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = ";inp",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmt("<{},{}>", { i(1), i(2) }), -- 替换为插入节点
    { condition = tex_utils.in_mathzone }
  ),

  s({
    trig = "exi",
    wordTrig = false,
    snippetType = "autosnippet",
    priority = 1,
  }, t("\\exists"), { condition = tex_utils.in_mathzone }),

  s({
    trig = ";any",
    wordTrig = false,
    snippetType = "autosnippet",
    priority = 1,
  }, t("\\forall"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "CC",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\mathbb{C}"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "RR",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\mathbb{R}"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "ZZ",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\mathbb{Z}"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "NN",
    wordTrig = false,
    snippetType = "autosnippet",
  }, t("\\mathbb{N}"), { condition = tex_utils.in_mathzone }),

  -- Derivatives and integrals
  --
  s(
    {
      trig = "par",
      snippetType = "autosnippet",
      wordTrig = false,
    },
    fmta("\\frac{\\partial <>}{\\partial <>} ", {
      i(1), -- 插入节点用于用户输入
      i(2), -- 插入节点用于用户输入
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "pa([A-Za-z])([A-Za-z])",
      snippetType = "autosnippet",
      wordTrig = false,
      regTrig = true,
    },
    fmta("\\frac{\\partial <>}{\\partial <>} ", {
      f(function(_, snip)
        return snip.captures[1]
      end), -- 捕获组
      f(function(_, snip)
        return snip.captures[2]
      end), -- 捕获组
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "p\\(" .. GREEK .. ")\\s",
      snippetType = "autosnippet",
      wordTrig = false,
      regTrig = true,
    },
    fmta("\\partial_{<>} ", {
      f(function(_, snip)
        return snip.captures[1]
      end), -- 捕获组
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "ph\\(" .. GREEK .. ")\\s",
      snippetType = "autosnippet",
      wordTrig = false,
      regTrig = true,
    },
    fmta("\\partial^{<>} ", {
      f(function(_, snip)
        return snip.captures[1]
      end), -- 捕获组
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "ddt",
      snippetType = "autosnippet",
      wordTrig = false,
    },
    fmta("\\frac{\\mathrm{d}<>}{\\mathrm{d}t}<> ", {
      i(1), -- 插入节点
      i(2), -- 插入节点
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s({
    trig = "d",
    wordTrig = false,
    priority = 100,
  }, t("\\mathrm{d} "), { condition = tex_utils.in_mathzone }),

  s(
    {
      trig = "([^\\\\])int",
      snippetType = "autosnippet",
      wordTrig = false,
      regTrig = true,
    },
    fmta("<>\\int", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "\\int ",
      snippetType = "autosnippet",
      wordTrig = false,
    },
    fmta("\\int <> \\, d<> ", {
      i(1), -- 插入节点
      i(2), -- 插入节点
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "dint",
      snippetType = "autosnippet",
      wordTrig = false,
    },
    fmta("\\int_{<>}^{<>} <> \\, d<> ", {
      i(1, "0"), -- 插入节点
      i(2, "1"), -- 插入节点
      i(3, "2"), -- 插入节点
      i(4, "3"), -- 插入节点
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s({
    trig = ",,",
    snippetType = "autosnippet",
    wordTrig = false,
  }, t("\\,"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "oint",
    snippetType = "autosnippet",
    wordTrig = false,
  }, t("\\oint"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "iint",
    snippetType = "autosnippet",
    wordTrig = false,
  }, t("\\iint"), { condition = tex_utils.in_mathzone }),

  s({
    trig = "iiint",
    snippetType = "autosnippet",
    wordTrig = false,
  }, t("\\iiint"), { condition = tex_utils.in_mathzone }),

  s(
    {
      trig = "oinf",
      snippetType = "autosnippet",
      wordTrig = false,
    },
    fmta("\\int_{0}^{\\infty} <> \\, \\mathrm{d}<> ", {
      i(1), -- 插入节点
      i(2), -- 插入节点
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    {
      trig = "infi",
      snippetType = "autosnippet",
      wordTrig = false,
    },
    fmta("\\int_{-\\infty}^{\\infty} <> \\, \\mathrm{d}<> ", {
      i(1), -- 插入节点
      i(2), -- 插入节点
    }),
    { condition = tex_utils.in_mathzone }
  ),
  --Trigonometry
  --
  s(
    {
      trig = "([^\\\\])(arcsin|sin|arccos|cos|arctan|tan|csc|sec|cot)",
      wordTrig = false,
      regTrig = true,
      trigEngine = "ecma",
      snippetType = "autosnippet",
      dscr = "Add backslash before trig funcs",
      priority = 50,
    },
    fmta("<>\\<>{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
      i(3),
    })
  ),
  s(
    {
      trig = "\\\\(arcsin|sin|arccos|cos|arctan|tan|csc|sec|cot)([A-Za-gi-z])",
      wordTrig = false,
      regTrig = true,
      trigEngine = "ecma",
      snippetType = "autosnippet",
      dscr = "Add space after trig funcs. Skips letter h to allow sinh, cosh, etc.",
      priority = 50,
    },
    fmta("\\<> <>{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
      i(3),
    })
  ),
  s(
    {
      trig = "\\\\(sinh|cosh|tanh|coth)([A-Za-z])",
      wordTrig = false,
      regTrig = true,
      trigEngine = "ecma",
      snippetType = "autosnippet",
      dscr = "Add space after hyperbolic trig funcs",
      priority = 50,
    },
    fmta("\\<> <>{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
      i(3),
    })
  ),
}
