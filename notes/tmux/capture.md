capture-pane [-aepPqCJN] [-b buffer-name] [-E end-line] [-S start-line] [-t target-pane]
    (alias: capturep)

- By default, it goes to a new tmux paste buffer, unless:
    - `-b` *buffer-name*  send it to that buffer
    - `-p`    send it to `stdout`
- `-e`    Include escape sequences for color
- `-J`    Join lines
- `-S`    Starting line number
    - Defaults to visible contents
    - `-S-`   From the beginning

Example:
```sh
tmux capture-pane -Jpe -S- | bat
tmux capture-pane -Jp -S- | nvim -

alias capture_pane="tmux capture-pane -Jp -S-"
```

```sh
# In neovim
:%!capture_pane -t\!  # capture last pane's contents
```
