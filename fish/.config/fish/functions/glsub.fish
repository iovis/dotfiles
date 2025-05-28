function glsub --wraps='git pull --recurse-submodules'
    git pull --recurse-submodules $argv
end
