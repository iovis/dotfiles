function rdd --wraps='rails db:drop' --description 'alias rdd=rails db:drop'
    rails db:drop $argv
end
