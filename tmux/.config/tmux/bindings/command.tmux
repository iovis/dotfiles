bind -N "Command mode" l switch-client -T command

bind -N "Open lazygit" -T command g {
  new-window -n lazygit lazygit
}

bind -N "Open htop" -T command h {
  new-window -n htop htop
}

bind -N "Tmux customization mode" -T command z {
  customize-mode -Z
}

## Justfile
bind -N "Open just" -T command j {
  if "test -f justfile" {
    new-window -n just just --choose --chooser "fzf-tmux -p80\%,80\% --prompt 'just> ' --reverse --info inline --preview 'just --show {}' --preview-window 'down'"
  } {
    display "No justfile!"
  }
}

bind -N "Run just dev" -T command s {
  if "test -f justfile" {
    new-window -n dev just dev
  } {
    display "No justfile!"
  }
}

bind -N "Run just console" -T command c {
  if "test -f justfile" {
    new-window -n console just console
  } {
    display "No justfile!"
  }
}

bind -N "Run just db" -T command d {
  if "test -f justfile" {
    new-window -n db just db
  } {
    display "No justfile!"
  }
}
