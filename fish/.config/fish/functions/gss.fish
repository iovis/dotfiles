function gss --wraps='git status -s'
    git status -s $argv
end
