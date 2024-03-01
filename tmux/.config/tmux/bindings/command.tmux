bind -N "Command mode" l switch-client -T command

bind -N "Open lazygit" -T command g {
  new-window -S -c "#{pane_current_path}" -n lazygit lazygit
}

bind -N "Open neovim with current pane contents" -T command j {
  run -b tn
}

bind -N "Open lazydocker" -T command k {
  new-window -S -c "#{pane_current_path}" -n lazydocker lazydocker
}

bind -N "Open htop" -T command h {
  new-window -Sn htop htop
}

bind -N "Open btop" -T command b {
  new-window -Sn btop btop
}

bind -N "Open numbat" -T command n {
  new-window -Sn numbat numbat
}

bind -N "Browse PRs for current branch" -T command p {
  run -b "gh pr view --web"
}

bind -N "Switch to git worktree" -T command w {
  run -b "cd #{pane_current_path} && gws"
}

bind -N "Tmux customization mode" -T command z {
  customize-mode -Z
}

## Justfile
bind -N "Run just dev" -T command s {
  if "test -f justfile" {
    new-window -Sn dev just dev
  } {
    display "No justfile!"
  }
}

bind -N "Run just open dev" -T command S {
  if "test -f justfile" {
    new-window -Sn dev just open dev
  } {
    display "No justfile!"
  }
}

bind -N "Run just console" -T command c {
  if "test -f justfile" {
    new-window -Sn console just console
  } {
    display "No justfile!"
  }
}

bind -N "Run just db" -T command d {
  if "test -f justfile" {
    new-window -Sn db just db
  } {
    display "No justfile!"
  }
}

bind -N "Run just open" -T command o {
  if "test -f justfile" {
    new-window -Sd just open
  } {
    display "No justfile!"
  }
}

bind -N "Run just test" -T command t {
  if "test -f justfile" {
    new-window -n test -d just test
  } {
    display "No justfile!"
  }
}
