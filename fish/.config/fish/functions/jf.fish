function jf --wraps=just
    just --choose --chooser "fzf-tmux -p50\%,50\% --prompt 'just> ' --reverse --info inline --preview 'just --show {}' --preview-window 'down'"
end
