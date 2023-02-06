function rsof --wraps='rspec --only-failures' --description 'alias rsof=rspec --only-failures'
    rspec --only-failures $argv
end
