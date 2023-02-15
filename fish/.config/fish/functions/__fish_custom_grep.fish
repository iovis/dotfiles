# Based on __fish_paginate
function __fish_custom_grep
    set -l cmd grep
    if command -q rg
        set cmd rg -S
    end

    fish_commandline_append "| $cmd "
end
