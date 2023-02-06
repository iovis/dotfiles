function rdtp --wraps='rails db:test:prepare' --description 'alias rdtp=rails db:test:prepare'
    rails db:test:prepare $argv
end
