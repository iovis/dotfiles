let g:sneak#use_ic_scs = 1
let g:sneak#label = 1

nmap f <Plug>Sneak_s
omap f <Plug>Sneak_s
xmap f <Plug>Sneak_s

nmap F <Plug>Sneak_S
omap F <Plug>Sneak_S
xmap F <Plug>Sneak_S

xmap t <Plug>Sneak_t
omap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap T <Plug>Sneak_T

hi Sneak      ctermbg=110 ctermfg=235 guibg=#8fafd7 guifg=#262626 cterm=NONE gui=NONE
hi SneakScope ctermbg=110 ctermfg=235 guibg=#8fafd7 guifg=#262626 cterm=NONE gui=NONE
