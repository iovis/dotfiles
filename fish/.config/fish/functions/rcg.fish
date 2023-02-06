function rcg --wraps='rails consults:generate --' --description 'alias rcg=rails consults:generate --'
    rails consults:generate -- $argv
end
