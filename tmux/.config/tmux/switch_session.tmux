bind g switch-client -T goto

# Show available session switchers
bind -T goto h run -b "~/.config/tmux/scripts/session_switcher"

# TODO: Plugin like harpoon?
bind -T goto d new-session -A -s dotfiles -c "~/.dotfiles/"
bind -T goto j new-session -A -s rubicon -c "~/Sites/rubicon/rubicon/"
bind -T goto k new-session -A -s rubicon-angular -c "~/Sites/rubicon/rubicon-angular/"

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
