function rcgp --wraps='rails consults:generate -- --with-patients' --description 'alias rcgp=rails consults:generate -- --with-patients'
    rails consults:generate -- --with-patients $argv
end
