function dcdn --wraps='docker compose down'
    docker compose down $argv
end
