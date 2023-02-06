function rdm --wraps='rails db:migrate' --description 'alias rdm=rails db:migrate'
    rails db:migrate $argv
end
