# https://github.com/fish-shell/fish-shell/blob/master/share/completions/tmux.fish
function __fish_ts_tmux_sessions -d 'available sessions'
    tmux list-sessions -F "#S	#{session_windows} windows created: #{session_created_string} [#{session_width}x#{session_height}]#{session_attached}" | sed 's/0$//;s/1$/ (attached)/' 2>/dev/null
end

complete -c ts --no-files -a '(__fish_ts_tmux_sessions)' -d target-session
