bind -N "Command mode" l switch-client -T command

bind -N "Open lazygit" -T command g {
  new-window -S -c "#{pane_current_path}" -n lazygit lazygit
}

bind -N "Open htop" -T command h {
  new-window -S -n htop htop
}

bind -N "Open nvim" -T command n {
  if "test -f Session.vim" {
    new-window -S -n nvim nvim -S Session.vim
  } {
    new-window -S -n nvim nvim
  }
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
bind -N "Open just" -T command j {
  if "test -f justfile" {
    new-window -n just -d just --choose --chooser "fzf-tmux -p80\%,80\% --prompt 'just> ' --reverse --info inline --preview 'just --show {}' --preview-window 'down' && tmux select-window -t ':=just'"
  } {
    display "No justfile!"
  }
}

bind -N "Run just dev" -T command s {
  if "test -f justfile" {
    new-window -Sd -n dev just dev
  } {
    display "No justfile!"
  }
}

bind -N "Run just console" -T command c {
  if "test -f justfile" {
    new-window -S -n console just console
  } {
    display "No justfile!"
  }
}

bind -N "Run just db" -T command d {
  if "test -f justfile" {
    new-window -S -n db just db
  } {
    display "No justfile!"
  }
}

bind -N "Run just open" -T command o {
  if "test -f justfile" {
    new-window -S -n open -d just open
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
