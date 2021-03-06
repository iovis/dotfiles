" Formatting
setlocal comments=
setlocal commentstring=>\ %s
setlocal wrap
setlocal textwidth=80
setlocal formatoptions+=tcoqnl1j
setlocal linebreak
setlocal breakindent
setlocal spelllang=es
" setlocal spell

" Better indention/hierarchy
setlocal formatlistpat=^\\s*                    " Optional leading whitespace
setlocal formatlistpat+=[                       " Start class
setlocal formatlistpat+=\\[({]\\?               " |  Optionally match opening punctuation
setlocal formatlistpat+=\\(                     " |  Start group
setlocal formatlistpat+=[0-9]\\+                " |  |  A number
setlocal formatlistpat+=\\\|[iIvVxXlLcCdDmM]\\+ " |  |  Roman numerals
setlocal formatlistpat+=\\\|[a-zA-Z]            " |  |  A single letter
setlocal formatlistpat+=\\)                     " |  End group
setlocal formatlistpat+=[\\]:.)}                " |  Closing punctuation
setlocal formatlistpat+=]                       " End class
setlocal formatlistpat+=\\s\\+                  " One or more spaces
setlocal formatlistpat+=\\\|^\\s*[-–+o*]\\s\\+  " Or ASCII style bullet points
