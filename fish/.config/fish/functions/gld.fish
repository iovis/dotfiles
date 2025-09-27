function gld --wraps='git log --patch'
    git -c diff.external=difft log -p --ext-diff $argv
end
