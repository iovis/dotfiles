function rdm --wraps='rails db:migrate'
    rails db:migrate $argv
end
