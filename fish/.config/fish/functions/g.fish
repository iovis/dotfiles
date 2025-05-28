function g --wraps=rg
    rg -Suu -g '!{.bzr,CVS,.git,.hg,.svn,.idea,.tox}' $argv
end
