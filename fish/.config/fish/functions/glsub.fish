function glsub --wraps='git pull --recurse-submodules' --description 'alias glsub=git pull --recurse-submodules'
    git pull --recurse-submodules $argv
end
