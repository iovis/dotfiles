function g --wraps=rg --description alias\ g=rg\ -Suu\ -g\ \'!\{.bzr,CVS,.git,.hg,.svn,.idea,.tox\}\'
    rg -Suu -g '!{.bzr,CVS,.git,.hg,.svn,.idea,.tox}' $argv
end
