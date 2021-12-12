require('gitsigns').setup {
  keymaps = {
    noremap = true,

    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

    ['n +q'] = '<cmd>lua require("gitsigns").toggle_current_line_blame()<CR>',
  },
  current_line_blame_opts = {
    delay = 100,
  }
}
