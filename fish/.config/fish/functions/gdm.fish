function gdm --wraps='git diff master...' --description 'alias gdm=git diff master...'
    git diff master... $argv
end
