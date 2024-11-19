# https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
# \x1b - escape code
# [0m  - reset color and text style
# [1m  - bold
# [34m - blue (fg)
# [44m - blue (bg) (fg + 10)
# [32m - green (fg)
# [1;34m - bold and blue fg
# [39m - reset color (fg)
# [22m - reset style
function log_step
    echo -e "\n$(blue "==>") $(bold $argv)\x1b[0m"
end
