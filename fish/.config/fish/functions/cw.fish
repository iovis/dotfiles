function cw --wraps=cargo\ watch\ -x\ \'nextest\ run\' --description alias\ cw=cargo\ watch\ -x\ \'nextest\ run\'
    cargo watch -x 'nextest run' $argv
end
