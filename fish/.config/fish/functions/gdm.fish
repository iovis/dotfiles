function gdm --wraps='git diff main...' --description 'alias gdm=git diff master...'
    git diff main... $argv
end
