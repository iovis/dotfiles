-- nnoremap ç <cmd>TroubleToggle quickfix<cr>
-- nnoremap Ç <cmd>TroubleToggle loclist<cr>
--
-- hi TroubleIndent   ctermfg=8  ctermbg=NONE guifg=#585858 guibg=NONE
-- hi TroubleFoldIcon ctermfg=20 ctermbg=NONE gui=bold guifg=#b8b8b8 guibg=NONE
--
-- augroup trouble
--   autocmd!
--   autocmd FileType Trouble setlocal relativenumber
-- augroup END

require("trouble").setup({
  mode = "quickfix",
  padding = false,
  action_keys = { -- key mappings for actions in the trouble list
    -- map to {} to remove a mapping, for example:
    -- close = {},
    toggle_preview = "p",
  },
})
