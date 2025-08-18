function gd --wraps='git diff'
    git -c diff.external=difft diff $argv
end
