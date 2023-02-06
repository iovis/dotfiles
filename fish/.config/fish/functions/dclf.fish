function dclf --wraps='docker compose logs -f' --description 'alias dclf=docker compose logs -f'
    docker compose logs -f $argv
end
