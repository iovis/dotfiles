function gcm --wraps='git checkout main|master' --description 'alias gcm=git checkout main|master'
    git switch main || git switch master
end
