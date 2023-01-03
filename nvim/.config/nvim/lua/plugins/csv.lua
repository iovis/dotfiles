return {
  "chrisbra/csv.vim",
  ft = "csv",
  config = function()
    local hi = require("user.utils").hi

    hi.CSVColumnEven = { bg = "#6C6C6C" }
    hi.CSVColumnOdd = {}
  end,
}
