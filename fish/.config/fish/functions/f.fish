function f --wraps=fd
    fd -u --exclude '.git' $argv
end
