function gdn --wraps='git diff --no-index'
    git diff --no-index $argv
end
