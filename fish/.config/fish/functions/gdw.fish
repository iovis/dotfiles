function gdw --wraps='git diff --color-words' --description 'alias gds=git diff --color-words'
    git diff --color-words $argv
end
