require('zen-mode').setup {
  window = {
    backdrop = 1,
    height = .9,
    width = .8,
    options = {
      -- Any vim.wo options
      signcolumn = 'no',
      number = false,
      relativenumber = false,
    },
  },
}

local u = require('utils')
u.nmap('<leader>z', ':ZenMode<cr>')
