function grbim --wraps='git rebase -i --rebase-merges'
    git rebase -i --rebase-merges $argv
end
