nnoremap yoo :call RestoreSession()<cr>

function! RestoreSession()
  if !empty(v:this_session)
    echo 'Already in a session'
    return
  endif

  try
    source Session.vim
  catch /E484:/
    echo 'Session not found, creating one'
    mksession!
  endtry
endfunction

function! s:persist()
  if !empty(v:this_session)
    mksession!
  endif
endfunction

augroup obsession
  autocmd!
  autocmd VimLeavePre * call s:persist()
  autocmd BufEnter * call s:persist()
augroup END
