# Smart pane switching with awareness of vim splits
# See: https://github.com/christoomey/vim-tmux-navigator
is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?|fzf|lazygit)(diff)?$'"

##########
# Prefix #
##########
unbind C-b
set -g prefix C-Space
bind Space send-prefix

# Quick find
bind f new-window\; send 'f && clear' Enter

# Quick settings
bind b attach -c "#{pane_current_path}"\; display-message "changed path to #{pane_current_path}"
bind s set-window-option synchronize-panes
bind w set -w automatic-rename

# Help & settings
bind ? list-keys
bind L customize-mode -Z

# Removing panes
bind Q confirm-before -p "kill the rest of the windows? (y/n)" "kill-window -a"
bind c new-window -c "#{pane_current_path}"
bind q confirm-before -p "reset session? (y/n)" 'new-window -c "#{pane_current_path}"; kill-window -a'
bind º confirm-before -p "kill-window #W? (y/n)" kill-window

# Split panes
bind H split-window -fv -c "#{pane_current_path}"
bind V split-window -fh -c "#{pane_current_path}"
bind h split-window -v -c "#{pane_current_path}"
bind v split-window -h -c "#{pane_current_path}"

# Move windows
bind -r < swap-window -dt -1
bind -r > swap-window -dt +1

# Move panes
bind -r down  swap-pane -dt "{down-of}"
bind -r left  swap-pane -dt "{left-of}"
bind -r right swap-pane -dt "{right-of}"
bind -r up    swap-pane -dt "{up-of}"

# Resize panes equally
bind = select-layout tiled

# Pass-through
bind C-l send-keys 'C-l'
bind C-k send-keys 'C-k'

#############
# No Prefix #
#############
# Session picker
bind -n C-f choose-tree -Zs

# Window switching
bind -n M-l  last-window
bind -n S-left  previous-window
bind -n S-right next-window

# Window indexing
bind -n M-1  select-window -t :=1
bind -n M-2  select-window -t :=2
bind -n M-3  select-window -t :=3
bind -n M-4  select-window -t :=4
bind -n M-5  select-window -t :=5
bind -n M-6  select-window -t :=6
bind -n M-7  select-window -t :=7
bind -n M-8  select-window -t :=8
bind -n M-9  select-window -t :=9

# Switch panes
bind -n C-h  if-shell "$is_vim" "send-keys C-h"  "select-pane -L"
bind -n C-j  if-shell "$is_vim" "send-keys C-j"  "select-pane -D"
bind -n C-k  if-shell "$is_vim" "send-keys C-k"  "select-pane -U"
bind -n C-l  if-shell "$is_vim" "send-keys C-l"  "select-pane -R"
bind -n C-\\ if-shell "$is_vim" 'send-keys C-\\' "select-pane -l" # c-ç

# Resize panes
bind -n C-down  resize-pane -D 5
bind -n C-left  resize-pane -L 5
bind -n C-right resize-pane -R 5
bind -n C-up    resize-pane -U 5

###############
#  Copy-mode  #
###############
unbind -T copy-mode-vi Enter
unbind -T copy-mode-vi Space

# Enter copy mode
bind -n C-_ if-shell "$is_vim" 'send-keys C-_' 'copy-mode'
bind    ñ   if-shell "$is_vim" 'send-keys ñ'   'copy-mode; send-key ?'

# Movement
bind -T copy-mode-vi H send-keys -X back-to-indentation
bind -T copy-mode-vi L send-keys -X end-of-line
bind -T copy-mode-vi K send-keys -X top-line
bind -T copy-mode-vi J send-keys -X bottom-line
bind -T copy-mode-vi d send-keys -X halfpage-down
bind -T copy-mode-vi u send-keys -X halfpage-up

# Search
bind -T copy-mode-vi ñ command-prompt -p "(search up)"   "send -X search-backward \"%%%\""
bind -T copy-mode-vi Ñ command-prompt -p "(search down)" "send -X search-forward \"%%%\""

# Marks
bind -T copy-mode-vi m   send-keys -X set-mark
bind -T copy-mode-vi "'" send-keys -X jump-to-mark

# Copy mode selection
bind -T copy-mode-vi v send-keys -X begin-selection
bind -T copy-mode-vi a send-keys -X copy-pipe
bind -T copy-mode-vi s send-keys -X select-word
bind -T copy-mode-vi c send-keys Escape 'V!'
bind -T copy-mode-vi C send-keys Escape 'v$!'
bind -T copy-mode-vi p send-keys -X select-word \; send-keys -X copy-pipe-and-cancel "reattach-to-user-namespace pbcopy"
bind -T copy-mode-vi P send-keys -X select-word \; send-keys -X copy-pipe-and-cancel "tmux paste-buffer"

# Switch panes
bind -T copy-mode-vi C-h  select-pane -L
bind -T copy-mode-vi C-j  select-pane -D
bind -T copy-mode-vi C-k  select-pane -U
bind -T copy-mode-vi C-l  select-pane -R
bind -T copy-mode-vi C-\\ select-pane -l # c-ç

# Resize panes
bind -T copy-mode-vi C-down  resize-pane -D 5
bind -T copy-mode-vi C-left  resize-pane -L 5
bind -T copy-mode-vi C-right resize-pane -R 5
bind -T copy-mode-vi C-up    resize-pane -U 5

# Quick search
bind -T copy-mode-vi U send-keys -X search-backward "(https?://|git@|git://|ssh://|ftp://|file:///)[[:alnum:]?=%/_.:,;~@!#$&()*+-]*"  # URLs
bind -T copy-mode-vi F send-keys -X search-backward "[[:digit:]]+(\\.[[:digit:]]+)?"  # Float numbers
bind -T copy-mode-vi O send-keys -X search-backward "\b([0-9a-f]{7,40}|[[:alnum:]]{52}|[0-9a-f]{64})\b"  # Hashes
bind -T copy-mode-vi I send-keys -X search-backward "[[:digit:]]{1,3}\\.[[:digit:]]{1,3}\\.[[:digit:]]{1,3}\\.[[:digit:]]{1,3}"  # IPs
bind -T copy-mode-vi D send-keys -X search-backward "[[:digit:]]{4}-[[:digit:]]{1,2}-[[:digit:]]{1,2}"  # Dates
bind -T copy-mode-vi R send-keys -X search-backward "(rspec|cucumber) [^:]+:[[:digit:]]+"  # Failed RSpec examples
bind -T copy-mode-vi < send-keys -X search-backward "(❯|❮) .+"  # Command Prompts

###########
#  Mouse  #
###########
bind -T copy-mode-vi WheelDownPane send -N5 -X scroll-down
bind -T copy-mode-vi WheelUpPane send -N5 -X scroll-up
bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'select-pane -t=; copy-mode -e; send-keys -M'"
bind -n WheelDownPane select-pane -t= \; send-keys -M
