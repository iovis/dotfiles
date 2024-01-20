local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local l = require("luasnip.extras").lambda
-- local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
-- local m = require("luasnip.extras").match
-- local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local conds = require("luasnip.extras.conditions")
-- local parse = ls.parser.parse_snippet

local commentstr = function()
  -- Update commentstring with treesitter
  local ok, ts_comment = pcall(require, "ts_context_commentstring.internal")
  if ok then
    ts_comment.update_commentstring({})
  end

  -- Substitute %s with one space
  return vim.api.nvim_get_option_value("commentstring", { buf = 0 }):gsub("%s*%%s", " ")
end

return {
  s("#!", {
    t("#!/usr/bin/env "),
    i(1, "bash"),
  }),
  s("todo", {
    p(commentstr),
    t("TODO: "),
    i(0),
  }),
  s("warn", {
    p(commentstr),
    t("WARN: "),
    i(0),
  }),
  s("note", {
    p(commentstr),
    t("NOTE: "),
    i(0),
  }),
  s("hack", {
    p(commentstr),
    t("HACK: "),
    i(0),
  }),
  s("fixme", {
    p(commentstr),
    t("FIXME: "),
    i(0),
  }),
}
