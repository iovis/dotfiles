function grbia --wraps='git rebase -i --autosquash'
    git rebase -i --autosquash $argv
end
