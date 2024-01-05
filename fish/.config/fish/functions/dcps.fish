function dcps --wraps='docker compose ps' --description 'alias dcps=docker compose ps'
    docker compose ps $argv
end
