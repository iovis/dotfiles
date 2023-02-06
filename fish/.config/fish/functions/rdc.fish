function rdc --wraps='rails db:create' --description 'alias rdc=rails db:create'
    rails db:create $argv
end
