syn match gitLolLine     /^[_\*|\/\\ ]\+\(\<\x\{4,40\}\>.*\)\?$/
syn match gitLolGraph    /^[_\*|\/\\ ]\+/ contained containedin=gitLolLine nextgroup=gitHashAbbrev skipwhite
syn match gitLolCommit   /\<\x\{4,40\}\> - / contained containedin=gitLolLine contains=gitHashAbbrev
syn match gitLolRefs     /([^)]*)\ze (\d\+ .\+ ago) <[^>]*>$/ contained containedin=gitLolLine
syn match gitLolDate     /(\d\+ .\+ ago)\ze <[^>]*>$/ contained containedin=gitLolLine nextgroup=gitLolIdentity skipwhite
syn match gitLolIdentity /<[^>]*>$/ contained containedin=gitLolLine

hi def link gitLolGraph    Comment
hi def link gitLolDate     gitDate
hi def link gitLolRefs     gitReference
hi def link gitLolIdentity gitIdentity
