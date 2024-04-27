function rubyjit --wraps='ruby --yjit' --description 'alias rubyjit ruby --yjit'
    ruby --yjit $argv
end
