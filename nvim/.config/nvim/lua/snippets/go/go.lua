return {
  s(
    "main",
    fmta(
      [[
        package main

        func main() {
          <>
        }
      ]],
      {
        i(0, "// body"),
      }
    ),
    { condition = conds.line_begin }
  ),
  -- Functions
  s(
    "f",
    fmta(
      [[
      func <fname>(<args>) <ret_type><space>{
        <body>
      }
      ]],
      {
        fname = i(1, "fname"),
        args = i(2),
        space = n(3, " "),
        ret_type = i(3),
        body = i(0, 'panic("todo")'),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "fm",
    fmta(
      [[
      func (self *<struct>) <fname>(<args>) <ret_type><space>{
        <body>
      }
      ]],
      {
        struct = i(1, "Receiver"),
        fname = i(2, "fname"),
        args = i(3),
        space = n(4, " "),
        ret_type = i(4),
        body = i(0, "// TODO: body"),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "fh",
    fmta(
      [[
      func <fname>(w http.ResponseWriter, r *http.Request) {
        <body>
      }
      ]],
      {
        fname = c(1, {
          i(1, "fname"),
          fmt("({} {}) {}", { i(1, "app"), i(2, "*application"), i(3, "fname") }),
        }),
        body = i(2, 'panic("todo")'),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "fmid",
    fmta(
      [[
      func <fname>(next http.Handler) http.Handler {
        return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
          <>
          next.ServeHTTP(w, r)
        })
      }
      ]],
      {
        fname = i(1, "middlewareName"),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  -- Structs
  s(
    "st",
    fmta(
      [[
      type <> struct {
        <>
      }
      ]],
      {
        i(1, "Name"),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  -- Conditionals
  s(
    "if",
    fmta(
      [[
      if <> {
        <>
      }
      ]],
      {
        i(1, "err != nil"),
        i(2),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "ife",
    fmta(
      [[
      if <> {
        <>
      } else {
        <>
      }
      ]],
      { i(1), i(2), i(3) }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "el",
    fmta(
      [[
      else {
        <>
      }
      ]],
      { i(1) }
    ),
    { condition = conds.line_begin }
  ),
  -- Loops
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
    "fori",
    fmt(
      [[
        for {} := 0; {} < {}; {}++ {{
          {}
        }}
      ]],
      {
        i(1, "i"),
        rep(1),
        i(2, "10"),
        rep(1),
        i(3),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "fora",
    fmt(
      [[
        for {} := range {} {{
          {}
        }}
      ]],
      { i(1, "item"), i(2, "collection"), i(3) }
    ),
    { condition = conds.line_begin }
  ),
  -- Testing
  s(
    "test",
    fmta(
      [[
      func Test<fname>(t *testing.T) {
        <body>
      }
      ]],
      {
        fname = i(1, "Name"),
        body = c(2, {
          i(1, 'panic("todo")'),
          fmta(
            [[
              tests := map[string]struct{
                input <>
                expected <>
              }{
                "English": {
                  input: "en",
                  expected: "Hello world",
                },
              }

              for name, test := range tests {
                t.Run(name, func(t *testing.T) {
                  got := greet(test.input)

                  if got != test.expected {
                    t.Errorf("Got: %q, Expected: %q", got, test.expected)
                  }
                })
              }
            ]],
            {
              i(1, "string"),
              i(2, "string"),
            }
          ),
        }),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "example",
    fmta(
      [[
      func Example<fname>(t *testing.T) {
        <body>
        // Output:
        // <output>
      }
      ]],
      {
        fname = i(1, "Name"),
        body = i(0, 'panic("todo")'),
        output = i(2, "Hello World!"),
      }
    ),
    { condition = conds.line_begin }
  ),
  -- Misc
  s(
    "pln",
    fmt("fmt.Println({})", {
      i(1),
    }),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    "prf",
    fmta('fmt.Printf("<>"<comma><>)', {
      i(1, "%s"),
      comma = n(2, ", "),
      i(2),
    }),
    {
      condition = conds.line_begin,
    }
  ),
}
