function g --wraps=rg
    rg -Suu --hyperlink-format=kitty -g '!{.bzr,CVS,.git,.hg,.svn,.idea,.tox}' $argv
end
