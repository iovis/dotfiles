# TODO: Should I just put the table on M-Space?
#       - M-Space Space would go to the last session?
if "type muxi" {
  run -b "muxi init"
}

##################
#  Quick Switch  #
##################
# scratch session popup
bind -n M-Space if -F '#{==:#{session_name},·}' {
  detach-client
} {
  display-popup -w 75% -h 75% -b rounded -d '#{pane_current_path}' -E "tmux new-session -A -s ·"
}

# notes
bind -n M-n if -F '#{==:#{session_name},notes}' {
  switch-client -l
} {
  new-session -A -s notes -c "~/Library/Mobile Documents/com~apple~CloudDocs/notes"
}
