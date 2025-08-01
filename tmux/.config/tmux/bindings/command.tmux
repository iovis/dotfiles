bind -N "Command mode" l {
  switch-client -T command
}

bind -N "Go to main window" -T command k {
  select-window -t :=1
}

bind -N "Open btop" -T command b {
  new-window -Sn btop btop
}

bind -N "Open neovim with current pane contents" -T command n {
  run -b tmux-capture
}

bind -N "Open lazygit" -T command g {
  new-window -S -c "#{pane_current_path}" -n lazygit lazygit
}

bind -N "Open htop" -T command h {
  new-window -Sn htop htop
}

bind -N "Open numbat" -T command m {
  new-window -Sn numbat numbat
}

bind -N "Browse PRs for current branch" -T command p {
  run -b "gh pr view --web"
}

bind -N "Open Notes" -T command u {
  new-window -Sn notes notes
}

bind -N "Switch to git worktree" -T command w {
  run -b "cd #{pane_current_path} && gws"
}

bind -N "Open yazi" -T command y {
  new-window -Sn yazi yazi
}

bind -N "Tmux customization mode" -T command z {
  customize-mode -Z
}

## Justfile
bind -N "Run just console" -T command c {
  if "test -f justfile" {
    new-window -Sn console just console
  } {
    display-message "No justfile!"
  }
}

bind -N "Run just db" -T command d {
  if "test -f justfile" {
    new-window -Sn db just db
  } {
    display-message "No justfile!"
  }
}

bind -N "Run just open" -T command o {
  if "test -f justfile" {
    new-window -Sd just open
  } {
    display-message "No justfile!"
  }
}

bind -N "Run just dev" -T command s {
  if "test -f justfile" {
    new-window -Sn dev just dev
  } {
    display-message "No justfile!"
  }
}

bind -N "Run just open dev" -T command S {
  if "test -f justfile" {
    new-window -Sn dev just open dev
  } {
    display-message "No justfile!"
  }
}

bind -N "Run just test" -T command t {
  if "test -f justfile" {
    new-window -n test -d just test
  } {
    display-message "No justfile!"
  }
}
