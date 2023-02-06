function gls --wraps='git log -S' --description 'alias gls=git log -S'
    git log -S $argv
end
