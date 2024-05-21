bindkey -e

autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up

autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search # Down
# bindkey "^N" autosuggest-accept
# bindkey "^Y" autosuggest-accept
