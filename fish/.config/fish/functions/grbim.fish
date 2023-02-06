function grbim --wraps='git rebase -i --rebase-merges' --description 'alias grbim=git rebase -i --rebase-merges'
    git rebase -i --rebase-merges $argv
end
