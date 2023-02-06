function hosts --wraps='sudo $EDITOR /etc/hosts' --description 'alias hosts=sudo $EDITOR /etc/hosts'
    sudo vim /etc/hosts $argv
end
