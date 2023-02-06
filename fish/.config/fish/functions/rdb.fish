function rdb --wraps='rails dbconsole' --description 'alias rdb=rails dbconsole'
    rails dbconsole $argv
end
