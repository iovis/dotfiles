function dcup --wraps='docker compose up -d --remove-orphans'
    docker compose up -d --remove-orphans $argv
end
