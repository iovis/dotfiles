function gpr --wraps='gh pr create --editor'
    gh pr create --editor $argv
end
