return {
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
