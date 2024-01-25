function dcstop --wraps='docker compose stop' --description 'alias dcstop=docker compose stop'
    docker compose stop $argv
end
