return {
  "chrisbra/csv.vim",
  ft = "csv",
  config = function()
    local hi = require("config.highlights").hi
    local c = require("config.highlights").colors

    hi.CSVColumnEven = { bg = c.gray3 }
    hi.CSVColumnOdd = {}
  end,
}
