function gca --wraps='git commit --amend --no-edit' --description 'alias gca=git commit --amend --no-edit'
    git commit --amend --no-edit $argv
end
