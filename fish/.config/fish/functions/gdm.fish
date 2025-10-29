function gdm --wraps='git diff-main'
    git -c diff.external=difft diff-main $argv
end
