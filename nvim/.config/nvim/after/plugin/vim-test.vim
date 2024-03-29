nnoremap <silent> <leader>si :TestNearest<cr>
nnoremap <silent> <leader>so :TestFile<cr>
nnoremap <silent> <leader>sa :TestSuite<cr>

function! TuxStrategy(cmd)
  execute 'Tux ' . a:cmd
endfunction

function! RustLogStrategy(cmd)
  execute 'Tux TEST_LOG=enabled ' . a:cmd . ' | bunyan'
endfunction

function! RustPrintStrategy(cmd)
  execute 'Tux ' . a:cmd . ' --nocapture'
endfunction

function! TestProfStrategy(cmd)
  execute 'Tux FPROF=1 FDOC=1 ' . a:cmd
endfunction

let g:test#custom_strategies = {
      \ 'tux': function('TuxStrategy'),
      \ 'rust_log': function('RustLogStrategy'),
      \ 'rust_print': function('RustPrintStrategy'),
      \ 'test_prof': function('TestProfStrategy'),
      \}

let g:test#strategy = 'tux'

let test#ruby#use_spring_binstub = 1
