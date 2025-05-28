function rubyjit --wraps='ruby --yjit'
    ruby --yjit $argv
end
