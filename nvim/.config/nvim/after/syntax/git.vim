syn match gitLolLine     /^[_\*|\/\\ ]\+\(\<\x\{4,40\}\>.*\)\?$/
syn match gitLolHead     /^[_\*|\/\\ ]\+\(\<\x\{4,40\}\> - ([^)]\+)\( ([^)]\+)\)\? \)\?/ contained containedin=gitLolLine
syn match gitLolRefs     /([^)]*)/ contained containedin=gitLolHead
syn match gitLolGraph    /^[_\*|\/\\ ]\+/ contained containedin=gitLolHead,gitLolCommit nextgroup=gitHashAbbrev skipwhite
syn match gitLolCommit   /^[^-]\+- / contained containedin=gitLolHead nextgroup=gitLolRefs skipwhite
syn match gitLolDate     /(\d\+ .\+ ago)/ contained containedin=gitLolLine nextgroup=gitLolIdentity skipwhite
syn match gitLolIdentity /<[^>]*>$/ contained containedin=gitLolLine

hi def link gitLolGraph    Comment
hi def link gitLolDate     gitDate
hi def link gitLolRefs     gitReference
hi def link gitLolIdentity gitIdentity
