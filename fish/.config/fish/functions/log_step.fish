# https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
# \x1b - escape code
# [0m  - reset
# [1m  - bold
# [34m - blue (fg)
# [44m - blue (bg)
# [1;34m - bold and blue fg
function log_step
    echo -e "\n\x1b[34m==>\x1b[0m \x1b[1m$argv\x1b[0m"
end
