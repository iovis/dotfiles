function __fish_custom_clipboard
    set -l buffer (commandline)

    if string match -rq '\|\s*(pbcopy|wl-copy)\s*$' -- $buffer
        commandline --replace (string replace -r '\s*\|\s*(pbcopy|wl-copy)\s*$' '' -- $buffer)
        return
    end

    set -l clipboard_cmd
    if command -q pbcopy
        set clipboard_cmd pbcopy
    else if command -q wl-copy
        set clipboard_cmd wl-copy
    else
        return 1
    end

    fish_commandline_append "| $clipboard_cmd "
end
