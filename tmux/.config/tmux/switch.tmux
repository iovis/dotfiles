bind g switch-client -T goto

bind -T goto r new-session -A -s rubicon -c "~/Sites/rubicon/rubicon/"
bind -T goto a new-session -A -s rubicon-angular -c "~/Sites/rubicon/rubicon-angular/"
bind -T goto d new-session -A -s · -c "~/.dotfiles/"

##################
#  Quick Switch  #
##################
# scratch session popup
bind -n M-Space if-shell -F '#{==:#{session_name},·}' {
  detach-client
} {
  display-popup -w 75% -h 75% -d '#{pane_current_path}' -E "tmux new-session -A -s ·"
}

# notes
bind -n M-n if-shell -F '#{==:#{session_name},notes}' {
  switch-client -l
} {
  new-session -A -s notes -c "~/Library/Mobile Documents/com~apple~CloudDocs/notes"
}
