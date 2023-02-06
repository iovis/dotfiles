function gprb --wraps='gh pr view --web' --description 'alias gprb=gh pr view --web'
    gh pr view --web $argv
end
