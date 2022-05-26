local u = require("utils")

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
  path = extract_name_from(path)

  return sn(
    nil,
    c(1, {
      i(1, path[2]),
      i(1, table.concat(path, "::")),
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
}
