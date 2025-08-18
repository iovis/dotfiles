function gdl --wraps='git log'
    git -c diff.external=difft log -p --ext-diff $argv
end
