function gemo
    gem outdated | rg --color=always -wf $DOTFILES/default/gems
end
