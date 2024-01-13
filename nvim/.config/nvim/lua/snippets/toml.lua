local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local conds = require("luasnip.extras.conditions")

return {
  s(
    "bench",
    fmt(
      [=[
        [[bench]]
        name = "{}"
        harness = false
      ]=],
      {
        i(1, "main"),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "workspace",
    fmt(
      [=[
        [workspace]
        resolver = "2"
        members = ["{}"]
      ]=],
      {
        i(1, "crates/*"),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "profiling",
    fmt(
      [=[
        [profile.profiling]
        inherits = "release"
        debug = true
      ]=],
      {}
    ),
    { condition = conds.line_begin }
  ),
}
