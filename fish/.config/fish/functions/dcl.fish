function dcl --wraps='docker compose logs' --description 'alias dcl=docker compose logs'
    docker compose logs $argv
end
