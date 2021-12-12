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

require('map_helpers')
nnoremap_s('<leader>z', ':ZenMode<cr>')
