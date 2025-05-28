function gds --wraps='git diff --staged'
    git diff --staged $argv
end
