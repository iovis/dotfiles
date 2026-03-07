function vd --wraps=nvim
    if not set -q argv[1]
        set argv .
    end

    nvim $argv
end
