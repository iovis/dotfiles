return {
  s("=", fmt("<%= {} %>", { i(1) }), { condition = conds.line_begin }),
  s("%", fmt("<% {} %>", { i(1) }), { condition = conds.line_begin }),
  s(
    "link_to",
    fmt("<%= link_to {}, {} %>", {
      i(1, "'Text'"),
      i(2, "root_path"),
    }),
    { condition = conds.line_begin }
  ),
  s(
    "render",
    fmt("<%= render {} %>", {
      i(1, "partial"),
    }),
    { condition = conds.line_begin }
  ),
  s(
    "each",
    fmt(
      [[
        <% {}.each do |{}| %>
          {}
        <% end %>
      ]],
      {
        i(1, "list"),
        i(2, "item"),
        i(0),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "if",
    fmt(
      [[
        <% if {} %>
          {}
        <% end %>
      ]],
      {
        i(1),
        i(2),
      }
    ),
    { condition = conds.line_begin }
  ),
  s(
    "if",
    fmt(
      [[
        <% if {} %>
          {}
        <% else %>
          {}
        <% end %>
      ]],
      {
        i(1),
        i(2),
        i(3),
      }
    ),
    { condition = conds.line_begin }
  ),
  s("pry", t("<% require 'pry'; binding.pry %>"), { condition = conds.line_begin }),
}
