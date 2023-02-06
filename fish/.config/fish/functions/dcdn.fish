function dcdn --wraps='docker compose down' --description 'alias dcdn=docker compose down'
    docker compose down $argv
end
