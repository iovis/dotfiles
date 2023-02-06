function venv --wraps='python3 -m venv .venv && activate && pipinit' --description 'alias venv=python3 -m venv .venv && activate && pipinit'
    python3 -m venv .venv && activate && pipinit $argv
end
