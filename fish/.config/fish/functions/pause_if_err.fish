function pause_if_err
    # command; pause_if_err
    test $status = 0 -o $status = 130; or pause
end
