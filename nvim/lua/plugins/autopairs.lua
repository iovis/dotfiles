local npairs = require("nvim-autopairs")

npairs.setup({
  check_ts = true,
  disable_filetype = { "TelescopePrompt", "fzf" },
  disable_in_macro = true,
})
