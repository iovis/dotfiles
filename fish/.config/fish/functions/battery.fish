function battery --wraps='pmset -g batt' --description 'alias battery=pmset -g batt'
    pmset -g batt $argv
end
