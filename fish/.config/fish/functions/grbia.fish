function grbia --wraps='git rebase -i --autosquash' --description 'alias grbia=git rebase -i --autosquash'
    git rebase -i --autosquash $argv
end
