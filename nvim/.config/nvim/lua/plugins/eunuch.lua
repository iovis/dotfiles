return {
  "tpope/vim-eunuch",
  event = "VeryLazy",
  config = function()
    local u = require("config.utils")
    u.ex.abbrev("re", "Remove")
  end,
}
