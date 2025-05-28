function gpf --wraps='git push --force-with-lease'
    git push --force-with-lease $argv
end
