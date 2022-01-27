local u = require("utils")

require("gitsigns").setup({
  current_line_blame_opts = {
    delay = 100,
  },
})

u.nmap("]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<cr>'", { expr = true })
u.nmap("[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<cr>'", { expr = true })
u.nmap("+q", "<cmd>Gitsigns toggle_current_line_blame<cr>")
