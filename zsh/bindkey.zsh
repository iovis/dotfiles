# Emacs keybindings
bindkey -e

autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up

autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search # Down

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

bindkey '^[^[[D' backward-word # alt-left
bindkey '^[^[[C' forward-word  # alt-right

bindkey "^N" autosuggest-accept
bindkey "^P" forward-word
bindkey "^U" backward-kill-line

bindkey -s "^[ñ" '~' # alt-ñ
bindkey -s "^[+" ']' # alt-+
bindkey -s "^[ç" '}' # alt-ç
