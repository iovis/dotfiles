function! TuxStrategy(cmd)
  execute 'Tux ' . a:cmd
endfunction

function! RustPrintStrategy(cmd)
  execute 'Tux RUST_LOG=debug ' . a:cmd . ' --nocapture'
endfunction

function! TestProfStrategy(cmd)
  execute 'Tux FPROF=1 FDOC=1 ' . a:cmd
endfunction

function! SpringStrategy(cmd)
  execute 'Tux script/spring ' . a:cmd
endfunction

let test#ruby#use_spring_binstub = 1
let g:test#rust#cargotest#test_options = {
      \ 'nearest': ['--', '--exact', '--nocapture', '--color=always'],
      \}

let g:test#custom_strategies = {
      \ 'tux': function('TuxStrategy'),
      \ 'rust_print': function('RustPrintStrategy'),
      \ 'test_prof': function('TestProfStrategy'),
      \ 'script_spring': function('SpringStrategy'),
      \}

let g:test#strategy = 'tux'

nnoremap <leader>si <cmd>TestNearest<cr>
nnoremap <leader>so <cmd>TestFile<cr>
nnoremap <leader>st <cmd>TestSuite<cr>
