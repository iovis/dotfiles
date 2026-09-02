function pb --wraps="yay -Gp"
    yay -Gp $argv | bat -p -l bash
end
