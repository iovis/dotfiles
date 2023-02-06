function pulls --wraps='gh pr list --web' --description 'alias pulls=gh pr list --web'
    gh pr list --web $argv
end
