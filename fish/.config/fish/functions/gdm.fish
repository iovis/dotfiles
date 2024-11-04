function gdm --wraps='git diff main...' --description 'alias gdm=git diff master...'
    git diff $(git default-branch)... $argv
end
