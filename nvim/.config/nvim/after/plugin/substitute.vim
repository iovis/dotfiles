nnoremap s <Nop>
xnoremap s <Nop>

nnoremap ss :%s/\v//g<left><left><left>

nnoremap <silent> s :set operatorfunc=SubstituteOperator<cr>g@
xnoremap <silent> s :<c-u>call SubstituteOperator(visualmode())<cr>

function! SubstituteOperator(type)
  if a:type ==# 'v'
    let isSameLine = getpos("'<")[1] - getpos("'>")[1] == 0

    if isSameLine
      let saved_unnamed_register = @@
      execute 'normal! `<v`>y'
      call feedkeys(':%s/\v' . escape(@@, '/\') . "//g\<left>\<left>", 't')
      let @@ = saved_unnamed_register
    else
      call feedkeys(":'<,'>s/\\v//g\<left>\<left>\<left>", 't')
    endif
  elseif a:type ==# 'V'
    call feedkeys(":'<,'>s/\\v//g\<left>\<left>\<left>", 't')
  elseif a:type ==# 'char'
    let saved_unnamed_register = @@
    execute 'normal! `[v`]y'
    call feedkeys(':%s/\v' . escape(@@, '/\') . "//g\<left>\<left>", 't')
    let @@ = saved_unnamed_register
  elseif a:type ==# 'line'
    call feedkeys(":'[,']s/\\v//g\<left>\<left>\<left>", 't')
  else
    echo 'TODO: ' . a:type . ' substitute mode'
    return
  endif
endfunction

" ------------------------------------------------
" substitute.vim plugin

" nnoremap S <Nop>
" " xnoremap S <Nop>
"
" nnoremap SS :S!/\v//g<left><left><left>
"
" nnoremap <silent> S :set operatorfunc=GlobalSubstituteOperator<cr>g@
" " xnoremap S :<c-u>call GlobalSubstituteOperator(visualmode())<cr>
"
" function! GlobalSubstituteOperator(type)
"   if a:type ==? 'v'
"     let isSameLine = getpos("'<")[1] - getpos("'>")[1] == 0
"
"     if isSameLine
"       let saved_unnamed_register = @@
"       execute 'normal! `<v`>y'
"       call feedkeys(':S!/\v' . escape(@@, '/\') . "//g\<left>\<left>", 't')
"       let @@ = saved_unnamed_register
"     else
"       call feedkeys(":S!/\\v//g\<left>\<left>\<left>", 't')
"     endif
"   elseif a:type ==# 'char'
"     let saved_unnamed_register = @@
"     execute 'normal! `[v`]y'
"     call feedkeys(':S!/\v' . escape(@@, '/\') . "//g\<left>\<left>", 't')
"     let @@ = saved_unnamed_register
"   elseif a:type ==# 'line'
"     call feedkeys(":S!/\\v//g\<left>\<left>\<left>", 't')
"   else
"     echo 'TODO: ' . a:type . ' substitute mode'
"     return
"   endif
" endfunction
