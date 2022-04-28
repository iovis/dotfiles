return {
  s({ trig = "x", dscr = "checkbox" }, {
    unpack(fmt("- [{}] {}", {
      i(1, " "),
      i(0),
    })),
  }, {
    condition = conds.line_begin,
  }),
}
