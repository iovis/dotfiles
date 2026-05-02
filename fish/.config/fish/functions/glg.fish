function glg --wraps="git log"
    if not set -q argv[1]
        set argv -5
    end

    git log --graph --pretty=format:'%C(yellow)%h%Creset - %s %C(auto)%d%Creset %Cgreen(%cr) %C(bold blue)<%an>%Creset' $argv
end
