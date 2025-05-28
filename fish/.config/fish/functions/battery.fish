function battery --wraps='pmset -g batt'
    pmset -g batt $argv
end
