function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()

  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "' . a:bufname . '"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx . 'close')
      return
    endif
  endfor

  if a:pfx ==? 'l' && len(getloclist(0)) == 0
    echohl ErrorMsg
    echo 'Location List is empty'
    return
  endif

  let winnr = winnr()
  exec('botright ' . a:pfx . 'open')

  if winnr() != winnr
    wincmd p
  endif
endfunction

nnoremap <silent> ç :call ToggleList("Quickfix List", 'c')<cr>
nnoremap <silent> Ç :call ToggleList("Location List", 'l')<cr>

