return {
  s(
    "alternate",
    fmta(
      [[
        "<>": {
          "alternate": "<>"
        },
      ]],
      {
        i(1, "app/*.rb"),
        i(2, "spec/{}_spec.rb"),
      },
      {
        condition = conds.line_begin,
      }
    )
  ),
  s(
    "proj",
    fmta(
      [[
        {
          "<>": {
            "alternate": "<>"
          },
          "<>": {
            "alternate": "<>"
          },
          "<>": {
            "alternate": "<>"
          },
          "<>": {
            "alternate": "<>"
          }
        }
      ]],
      {
        i(1, "app/*.rb"),
        i(2, "spec/{}_spec.rb"),
        i(3, "spec/*_spec.rb"),
        i(4, "app/{}.rb"),
        i(5, "Gemfile"),
        i(6, "Gemfile.lock"),
        rep(6),
        rep(5),
      },
      {
        condition = conds.line_begin,
      }
    )
  ),
  s(
    "ruby",
    fmta(
      [[
        {
          "lib/*.rb": {
            "alternate": "spec/{}_spec.rb"
          },
          "spec/*_spec.rb": {
            "alternate": "lib/{}.rb"
          },
          "Gemfile": {
            "alternate": "Gemfile.lock"
          },
          "Gemfile.lock": {
            "alternate": "Gemfile"
          }
        }
      ]],
      {},
      {
        condition = conds.line_begin,
      }
    )
  ),
  s(
    "rails",
    fmta(
      [[
        {
          "app/*.rb": {
            "alternate": "spec/{}_spec.rb"
          },
          "spec/*_spec.rb": {
            "alternate": "app/{}.rb"
          },
          "lib/*.rb": {
            "alternate": "spec/lib/{}_spec.rb"
          },
          "spec/lib/*_spec.rb": {
            "alternate": "lib/{}.rb"
          },
          "Gemfile": {
            "alternate": "Gemfile.lock"
          },
          "Gemfile.lock": {
            "alternate": "Gemfile"
          }
        }
      ]],
      {},
      {
        condition = conds.line_begin,
      }
    )
  ),
}
