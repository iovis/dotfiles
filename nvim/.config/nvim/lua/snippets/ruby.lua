local u = require("config.utils")

local function extract_name_from(path)
  path = vim.split(path, "/", { trimempty = true })

  -- Keep only the last two elements of the path
  path = { unpack(path, #path - 1, #path) }

  -- Remove extension from file
  path[#path] = path[#path]:gsub("%.rb", "")

  -- PascalCase all
  for j, value in ipairs(path) do
    path[j] = u.pascal_case(value)
  end

  return path
end

local function constant_name_choices()
  local path = vim.api.nvim_buf_get_name(0)
  local class_name = extract_name_from(path)

  return sn(
    nil,
    c(1, {
      i(1, class_name[2]),
      i(1, table.concat(class_name, "::")),
    })
  )
end

return {
  s(
    "case",
    fmt(
      [[
        case {}
        when {}
          {}
        end
      ]],
      {
        i(1, "object"),
        i(2, "condition"),
        i(3, "# body"),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "class",
    fmt(
      [[
        class {name}{parent}
          {}
        end
      ]],
      {
        name = d(1, constant_name_choices),
        parent = c(2, {
          i(1),
          {
            t(" < "),
            i(1, "Parent"),
          },
        }),
        i(0),
      }
    )
  ),
  s(
    "inj",
    fmt(
      [[
        include Injectable

        {deps}

        def call
          {}
        end
      ]],
      {
        deps = i(1, "# dependencies or arguments"),
        i(0, "# body"),
      }
    )
  ),
  s(
    "mod",
    fmt(
      [[
        module {name}
          {}
        end
      ]],
      {
        name = d(1, constant_name_choices),
        i(0),
      }
    )
  ),
  s(
    "dep",
    fmt("dependency{}", {
      c(1, {
        {
          t(" :"),
          i(1, "service_name"),
        },
        fmta("(:<>) { <> }", { i(1, "name"), i(2, "ServiceName") }),
      }),
    })
  ),
  parse("arg", "argument :${1:name}"),
  -- RSpec
  s("dc", t("described_class.")),
  s(
    "desc",
    fmt(
      [[
        describe '{}' do
          {}
        end
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "cont",
    fmt(
      [[
        context '{}' do
          {}
        end
      ]],
      {
        i(1),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "it",
    fmt("it {}", {
      c(1, {
        sn(
          nil,
          fmt(
            [[
              '{}' do
                {}
              end
            ]],
            { i(1), r(2, "block", i(1)) }
          )
        ),
        sn(nil, fmta("{ <> }", { r(1, "block", i(1)) })),
      }),
    }),
    { condition = conds.line_begin }
  ),
  s(
    "its",
    fmta("it { is_expected.<to> }", {
      to = c(1, {
        fmt("to {eq} {expected}", {
          eq = r(1, "eq", i(1, "eq")),
          expected = r(2, "expected", i(2)),
        }),
        fmt("not_to {eq} {expected}", {
          eq = r(1, "eq", i(1, "eq")),
          expected = r(2, "expected", i(2)),
        }),
      }),
    }),
    { condition = conds.line_begin }
  ),
  s(
    "bef",
    fmt("before {}{space}{}", {
      i(1),
      space = n(1, " "),
      c(2, {
        sn(
          nil,
          fmt(
            [[
              do
                {}
              end
            ]],
            { r(1, "block", i(1)) }
          )
        ),
        sn(nil, fmta("{ <> }", { r(1, "block", i(1)) })),
      }),
    }),
    { condition = conds.line_begin }
  ),
  s(
    "aft",
    fmt("after {}{space}{}", {
      i(1),
      space = n(1, " "),
      c(2, {
        sn(
          nil,
          fmt(
            [[
              do
                {}
              end
            ]],
            { r(1, "block", i(1)) }
          )
        ),
        sn(nil, fmta("{ <> }", { r(1, "block", i(1)) })),
      }),
    }),
    { condition = conds.line_begin }
  ),
  s(
    "let",
    fmt("let{} {}", {
      c(1, {
        sn(nil, fmt("(:{})", { r(1, "name", i(1)) })),
        sn(nil, fmt("!(:{})", { r(1, "name", i(1)) })),
      }),
      c(2, {
        sn(nil, fmta("{ <> }", { r(1, "block", i(1)) })),
        sn(
          nil,
          fmt(
            [[
              do
                {}
              end
            ]],
            { r(1, "block", i(1)) }
          )
        ),
      }),
    }),
    { condition = conds.line_begin }
  ),
  s(
    "subj",
    fmt("subject {}", {
      c(1, {
        sn(nil, fmta("{ <> }", { r(1, "block", i(1)) })),
        sn(
          nil,
          fmt(
            [[
              do
                {}
              end
            ]],
            { r(1, "block", i(1)) }
          )
        ),
      }),
    }),
    { condition = conds.line_begin }
  ),
  s(
    "exp",
    fmt("expect{expect}.{to}", {
      expect = c(1, {
        fmta("(<exp>)", {
          exp = r(1, "exp", i(1)),
        }),
        fmta("  { <exp> }", {
          exp = r(1, "exp", i(1)),
        }),
      }),
      to = c(2, {
        fmt("to {eq} {expected}", {
          eq = r(1, "eq", i(1, "eq")),
          expected = r(2, "expected", i(2)),
        }),
        fmt("not_to {eq} {expected}", {
          eq = r(1, "eq", i(1, "eq")),
          expected = r(2, "expected", i(2)),
        }),
      }),
    }),
    { condition = conds.line_begin }
  ),
  -- Yard
  parse("ret", "# @return [${1:type}] ${0:Description}"),
  parse("param", "# @param ${1:name} [${2:type}] ${0:Description}"),
  s(
    "attr",
    fmt(
      [[
        # @!attribute [r] {}
        #   @return [{}] {}
      ]],
      {
        i(1, "attr_name"),
        i(2, "ret_type"),
        i(0, "Description"),
      }
    ),
    { condition = conds.line_begin }
  ),
  -- Misc
  s("frozenstring", t("# frozen_string_literal: true"), {
    condition = conds.line_begin,
  }),
  s("r", fmt("attr_reader :{}", { i(0, "attr_name") }), {
    condition = conds.line_begin,
  }),
  s("w", fmt("attr_writer :{}", { i(0, "attr_name") }), {
    condition = conds.line_begin,
  }),
  s("rw", fmt("attr_accessor :{}", { i(0, "attr_name") }), {
    condition = conds.line_begin,
  }),
  s("pry", t("require 'pry-byebug'; binding.pry"), {
    condition = conds.line_begin,
  }),
  s({ trig = ",pry", snippetType = "autosnippet" }, t("binding.pry")),
  s("b", fmta("{ |<>| <> }", { i(1, "args"), i(2) })),
  s(
    "do",
    fmt(
      [[
        do {pipe}{}{pipe}
          {}
        end
      ]],
      {
        i(1, "args"),
        i(2, "# body"),
        pipe = n(1, "|"),
      }
    )
  ),
  s(
    "rubocopdisable",
    fmt(
      [[
        # rubocop: disable {}
        {visual_selection}
        # rubocop: enable {}
      ]],
      {
        i(1),
        visual_selection = dl(2, l.LS_SELECT_DEDENT),
        rep(1),
      }
    ),
    { condition = conds.line_begin }
  ),
}
