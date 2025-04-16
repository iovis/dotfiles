function psg --wraps='ps aux | rg' --description 'alias psg ps aux | rg'
    ps aux | rg $argv
end
