nnoremap d!       :DB w:db =<space>
nnoremap d<cr>    :execute 'TuxBg pgcli ' . CurrentDB()<cr>
nnoremap d<space> :DB<space>
nnoremap d?       :echo CurrentDB()<cr>

function! CurrentDB()
  return exists('w:db') ? w:db : DotenvGet('DATABASE_URL')
endf
