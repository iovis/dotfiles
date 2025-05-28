function dcps --wraps='docker compose ps'
    docker compose ps $argv
end
