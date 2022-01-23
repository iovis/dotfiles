# Emacs keybindings
bindkey -e

autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "$key[Up]" up-line-or-beginning-search

autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search # Down
bindkey "$key[Down]" down-line-or-beginning-search

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

bindkey '^[^[[D' backward-word # alt-left
bindkey '^[^[[C' forward-word  # alt-right

bindkey "^P" forward-word
bindkey "^U" backward-kill-line

bindkey -s "^[ñ" '~' # alt-ñ
bindkey -s "^[+" ']' # alt-+
bindkey -s "^[ç" '}' # alt-ç
