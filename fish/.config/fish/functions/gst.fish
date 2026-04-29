function gst --wraps='git stash'
    git stash push $argv
end
