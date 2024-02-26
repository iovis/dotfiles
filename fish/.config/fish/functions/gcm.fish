function gcm --wraps='git checkout master' --description 'alias gcm=git checkout master'
    git checkout $REVIEW_BASE $argv
end
