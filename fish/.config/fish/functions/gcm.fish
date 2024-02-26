function gcm --wraps='git checkout main' --description 'alias gcm=git checkout master'
    git checkout $REVIEW_BASE $argv
end
