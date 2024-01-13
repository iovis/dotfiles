local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
-- local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
-- local p = require("luasnip.extras").partial
-- local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.conditions")
local parse = ls.parser.parse_snippet

local u = require("config.utils")

-- https://github.com/L3MON4D3/LuaSnip/issues/944
local function visual_selection(_, parent)
  return parent.snippet.env.LS_SELECT_DEDENT or {}
end

local extract_name_from = function(path)
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

local constant_name_choices = function()
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
  s("#!", t("#!/usr/bin/env ruby"), {
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
  s("pry", t("require 'pry'; binding.pry"), {
    condition = conds.line_begin,
  }),
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
        {block}
        # rubocop: enable {}
      ]],
      {
        i(1),
        block = f(visual_selection),
        rep(1),
      }
    ),
    { condition = conds.line_begin }
  ),
}
