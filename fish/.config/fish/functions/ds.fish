function ds --wraps='du -sh * .* | sort -rh'
    du -sh * .* | sort -rh $argv
end
