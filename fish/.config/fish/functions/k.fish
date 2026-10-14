function k --wraps=command
    # Multiple tmux command arguments bypass the shell and cannot run Fish functions.
    if test (count $argv) -gt 1
        set argv (string escape -- $argv | string join ' ')
    end

    tmux new-pane -x 60% -y 60% -c "#{pane_current_path}" $argv \; move-pane -P centre
end
