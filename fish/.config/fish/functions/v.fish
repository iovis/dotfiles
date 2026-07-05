function v --wraps=nvim
    if not isatty stdin
        nvim $argv
    else if set -q argv[1]
        nvim $argv
    else if test -f Session.vim
        nvim -S Session.vim
    else
        nvim
    end
end
