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

let test#ruby#use_spring_binstub = 1
let g:test#custom_strategies = {
      \ 'tux': function('TuxStrategy'),
      \ 'rust_log': function('RustLogStrategy'),
      \ 'rust_print': function('RustPrintStrategy'),
      \ 'test_prof': function('TestProfStrategy'),
      \}

if g:neotest_enabled
  nnoremap <leader>sI <cmd>TestNearest -strategy=tux<cr>
  nnoremap <leader>sO <cmd>TestFile -strategy=tux<cr>
  nnoremap <leader>sa <cmd>TestSuite -strategy=tux<cr>
else
  let g:test#strategy = 'tux'

  nnoremap <leader>si <cmd>TestNearest<cr>
  nnoremap <leader>so <cmd>TestFile<cr>
  nnoremap <leader>sa <cmd>TestSuite<cr>
endif
