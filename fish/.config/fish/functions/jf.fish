function jf
    tmux popup -w 75\% -h 50\% -b rounded -T " just " "just --choose --chooser \"fzf --prompt 'just> ' --reverse --info inline-right --header=' ' --no-input --preview 'just --show {}' --preview-window 'right:75%' --bind 'j:down,k:up,q:abort,i,/:show-input+unbind(j,k,q,i,/,x)' --bind 'alt-r:change-preview-window(down|right)'\""
end
