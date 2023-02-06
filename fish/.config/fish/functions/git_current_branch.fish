function git_current_branch
    set ref (git symbolic-ref HEAD 2> /dev/null)

    if test $status = 0
        echo (string replace 'refs/heads/' '' $ref)
    end
end
