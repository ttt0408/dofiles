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

-- update for cases
--
local generate_cases = function(args, snip)
  local rows = tonumber(snip.captures[1]) or 2 -- default option 2 for cases
  local cols = 2 -- fix to 2 cols
  local nodes = {}
  local ins_indx = 1
  for j = 1, rows do
    table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
    ins_indx = ins_indx + 1
    for k = 2, cols do
      table.insert(nodes, t(" & "))
      table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
      ins_indx = ins_indx + 1
    end
    table.insert(nodes, t({ ",", "" }))
  end
  -- fix last node.
  table.remove(nodes, #nodes)
  return sn(nil, nodes)
end

-- Identity matrix
--
local identity_matrix = function(args, snip)
  local n = tonumber(snip.captures[1])
  local arr = {}
  for j = 1, n do
    arr[j] = {}
    for i = 1, n do
      arr[j][i] = (i == j) and "1" or "0"
    end
  end

  local output = {}
  for k, row in ipairs(arr) do
    local store = t(table.concat(row, " & "))
    table.insert(output, store)
    if k < #arr then
      table.insert(output, t({ "\\\\", "" }))
    end
  end
  return sn(nil, output)
end
-- matrix generate
--
local mat_type = function(args, snip)
  local bracket = tostring(snip.captures[3])
  local type = ""
  -- 确定矩阵环境类型
  if bracket == "y" or bracket == "Y" then
    type = "pmatrix" -- 圆括号
  elseif bracket == "f" or bracket == "F" then
    type = "bmatrix" -- 方括号
  elseif bracket == "h" or bracket == "H" then
    type = "Bmatrix" -- 花括号
  elseif bracket == "d" or bracket == "D" then
    type = "vmatrix" -- 单竖线
  elseif bracket == "n" or bracket == "N" then
    type = "Vmatrix" -- 双竖线
  else
    type = "pmatrix" -- 默认使用圆括号
  end
  return type
end
local mat_generate = function(args, snip)
  local rows = tonumber(snip.captures[1])
  local cols = tonumber(snip.captures[2])
  local nodes = {}
  local ins_indx = 1
  for j = 1, rows do
    local store1 = 1 + (j - 1) * cols
    table.insert(nodes, i(store1, "e"))
    ins_indx = ins_indx + 1
    for k = 2, cols do
      local store2 = k + (j - 1) * cols
      table.insert(nodes, t(" & "))
      table.insert(nodes, i(store2, "e"))
      ins_indx = ins_indx + 1
    end
    table.insert(nodes, t({ " \\\\", "" }))
  end
  -- fix last node.
  nodes[#nodes] = t(" \\\\")
  return sn(nil, nodes)
end
return {
  -- cases
  --
  s(
    { trig = "(%d?)cases", name = "cases", desc = "cases", regTrig = true, snippetType = "autosnippet" },
    fmta(
      [[
  cases(
  <>
  )<>]],
      { d(1, generate_cases), i(0) }
    ),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    {
      trig = "iden(%d)",
      regTrig = true,
      wordTrig = true,
      snippetType = "autosnippet",
      desc = "generate Identity N*N",
      priority = 120,
    },
    fmta(
      [[
     \begin{pmatrix}
     <>
     \end{pmatrix}
     ]],
      { d(1, identity_matrix) }
    ),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    {
      trig = "(\\d)(\\d)(y|Y|f|F|h|H|d|D|n|N)\\3",
      regTrig = true,
      trigEngine = "ecma",
      wordTrig = true,
      snippetType = "autosnippet",
      desc = "generate Identity N*N",
      priority = 120,
    },
    fmta(
      [[
     \begin{<>}
     <>
     \end{<>}
     ]],
      {
        f(mat_type),
        d(1, mat_generate),
        f(mat_type),
      }
    ),
    { condition = tex_utils.in_mathzone }
  ),
}
