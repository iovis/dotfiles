local function odin_proc()
  return sn(
    nil,
    fmta(
      [[
        <procname> :: proc(<args>)<arrow><ret_type> {
          <body>
        }
      ]],
      {
        procname = i(1, "procname"),
        args = i(2),
        arrow = n(3, " -> "),
        ret_type = i(3),
        body = i(4, "// body"),
      }
    )
  )
end

return {
  s(
    "main",
    fmta(
      [[
        package main

        import "core:fmt"

        main :: proc() {
          <body>
        }
      ]],
      {
        body = i(0, "// body"),
      }
    ),
    { condition = conds.line_begin }
  ),
  s("f", d(1, odin_proc), {
    condition = conds.line_begin,
  }),
  s("pf", fmt("@(private)\n{}", { d(1, odin_proc) }), {
    condition = conds.line_begin,
  }),
  s("sf", fmt('@(private="file")\n{}', { d(1, odin_proc) }), {
    condition = conds.line_begin,
  }),
  s(
    "st",
    fmta(
      [[
        <> :: struct {
          <>
        }
      ]],
      { i(1), i(2) }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "enum",
    fmta(
      [[
        <> :: enum {
          <>
        }
      ]],
      { i(1), i(2) }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "if",
    fmta(
      [[
        if <> {
          <>
        }
      ]],
      { i(1), i(2) }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "for",
    fmta(
      [[
        for <> {
          <>
        }
      ]],
      { i(1), i(2) }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "test",
    fmta(
      [[
        @(test)
        <test_name> :: proc(t: ^testing.T) {
          <>
        }
      ]],
      {
        test_name = i(1, "name"),
        i(2),
      }
    ),
    { condition = conds.line_begin }
  ),
  s("exp", fmt("testing.expect(t, {})", { i(1) }), {
    condition = conds.line_begin,
  }),
  s("ase", fmt("testing.expect_value(t, {}, {})", { i(1, "expected"), i(2, "actual") }), {
    condition = conds.line_begin,
  }),
  s("p", fmta("fmt.println(<>)", { i(1) }), {
    condition = conds.line_begin,
  }),
  s("ep", fmta("fmt.eprintln(<>)", { i(1) }), {
    condition = conds.line_begin,
  }),
  s(
    "aoc",
    fmta(
      [[
        package main

        import "core:fmt"
        import "core:testing"

        main :: proc() {
          input :: #load("./input.txt", string)
          fmt.println("p1 =", p1(input))
        }

        p1 :: proc(input: string) ->> uint {
          total: uint = 0
          return total
        }

        @(test)
        p1_test :: proc(t: ^testing.T) {
          input := ""

          testing.expect_value(t, p1(input), 0)
        }
      ]],
      {}
    ),
    { condition = conds.line_begin }
  ),
}
