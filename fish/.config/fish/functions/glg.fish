function glg --wraps="git log"
    if not set -q argv[1]
        set argv -5
    end

    git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' $argv
end
