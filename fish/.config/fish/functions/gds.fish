function gds
    git status -s
    echo
    git --no-pager -c diff.external=difft diff
end
