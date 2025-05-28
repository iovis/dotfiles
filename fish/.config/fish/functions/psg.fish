function psg --wraps='ps aux | rg'
    ps aux | rg $argv
end
