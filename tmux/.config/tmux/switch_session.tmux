bind g switch-client -T goto

# TODO: Plugin like harpoon?
bind -T goto g new-session -A -s · -c "~/.dotfiles/"
bind -T goto j new-session -A -s rubicon -c "~/Sites/rubicon/rubicon/"
bind -T goto k new-session -A -s rubicon-angular -c "~/Sites/rubicon/rubicon-angular/"

##################
#  Quick Switch  #
##################
# scratch session popup
bind -n M-Space if -F '#{==:#{session_name},·}' {
  detach-client
} {
  display-popup -w 75% -h 75% -d '#{pane_current_path}' -E "tmux new-session -A -s ·"
}

# notes
bind -n M-n if -F '#{==:#{session_name},notes}' {
  switch-client -l
} {
  new-session -A -s notes -c "~/Library/Mobile Documents/com~apple~CloudDocs/notes"
}
