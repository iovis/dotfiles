# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
# export KEYTIMEOUT=1
bindkey -v

## Make visual mode actually visible
zle_highlight=( region:bg=229,fg=235 )

## Insert mode
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

bindkey "^P" forward-word
bindkey "^U" backward-kill-line
bindkey "^K" kill-line

bindkey -s "^[ñ" '~' # alt-ñ
bindkey -s "^[+" ']' # alt-+
bindkey -s "^[ç" '}' # alt-ç

bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line
bindkey "^[." insert-last-word
bindkey "kj" vi-cmd-mode

# Fix delete characters
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char

## Normal mode
bindkey -M vicmd H vi-first-non-blank
bindkey -M vicmd L vi-end-of-line
bindkey -M vicmd ñ vi-history-search-backward
bindkey -M vicmd Ñ vi-history-search-forward

## Select brackets ci(, ca[
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done

## Select quotes
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

## Surround
# This doesn't allow yss to operate on a line but `VS` will work
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround

bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround
bindkey -a -s " '" "cs\"'"  # quick quote change
bindkey -a -s ' "' "cs'\""
