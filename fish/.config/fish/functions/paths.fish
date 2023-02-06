function paths --wraps=echo\ \$PATH\ \|\ tr\ \'\ \'\ \'\\n\' --description alias\ paths=echo\ \$PATH\ \|\ tr\ \'\ \'\ \'\\n\'
    echo $PATH | tr ' ' '\n' $argv
end
