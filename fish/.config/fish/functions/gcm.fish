function gcm --wraps='git switch main|master'
    git switch $(git default-branch)
end
