function psg --wraps='rg'
    ps aux | rg $argv
end
