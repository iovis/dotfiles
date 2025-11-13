bindkey -e

bindkey "^U" backward-kill-line

autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up

autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search # Down

# alt + arrow keys to move by word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

bindkey "^[l" forward-char
bindkey "^[w" forward-word
