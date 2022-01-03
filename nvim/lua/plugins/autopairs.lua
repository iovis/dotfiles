local npairs = require("nvim-autopairs")

npairs.setup({
  check_ts = true,
  disable_filetype = { "TelescopePrompt", "fzf" },
})

npairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))
npairs.add_rules(require("nvim-autopairs.rules.endwise-ruby"))
