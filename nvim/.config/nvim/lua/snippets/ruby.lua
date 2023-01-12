local u = require("user.utils")

local extract_name_from = function(path)
  path = vim.split(path, "/", { trimempty = true })

  -- Keep only the last two elements of the path
  path = { unpack(path, #path - 1, #path) }

  -- Remove extension from file
  path[#path] = path[#path]:gsub("%.rb", "")

  -- PascalCase all
  for i, value in ipairs(path) do
    path[i] = u.pascal_case(value)
  end

  return path
end

local contant_name_choices = function()
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
    "class",
    fmt(
      [[
        class {name}{parent}
          {}
        end
      ]],
      {
        name = d(1, contant_name_choices),
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
        name = d(1, contant_name_choices),
        i(0),
      }
    )
  ),
  s(
    "dep",
    fmt(
      [[
        dependency{}
      ]],
      {
        c(1, {
          {
            t(" :"),
            i(1, "service_name"),
          },
          fmta("(:<>) { <> }", { i(1, "name"), i(2, "ServiceName") }),
        }),
      }
    )
  ),
  parse("arg", "argument :${1:name}"),
  s("esig", t("extend T::Sig")),
  parse("sig", "sig { $1 }"),
  parse("sigv", "sig { void }"),
  parse("sigb", "sig { returns(T::Boolean) }"),
  s(
    "sigd",
    fmt(
      [[
        sig do
          {}
        end
      ]],
      { i(1) }
    )
  ),
  parse("ts", "# typed: strict"),
  parse("tt", "# typed: true"),
  parse("ret", "# @return [$1]"),
  s(
    "attr",
    fmt(
      [[
        # @!attribute [r] {}
        #   @return [{}]
      ]],
      {
        i(1),
        i(2),
      }
    ),
    { condition = conds.line_begin }
  ),
}
