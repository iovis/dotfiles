function rgm --wraps='rails generate migration' --description 'alias rgm=rails generate migration'
    rails generate migration $argv
end
