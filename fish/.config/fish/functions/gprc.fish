function gprc --wraps='gh pr checkout' --description 'alias gprc=gh pr checkout'
    gh pr checkout $argv
end
