return {
  "chrisbra/csv.vim",
  ft = "csv",
  config = function()
    local u = require("user.utils")

    u.highlight("CSVColumnEven", { bg = "#6C6C6C" })
    u.highlight("CSVColumnOdd", {})
  end,
}
