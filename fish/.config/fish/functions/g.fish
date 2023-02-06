function g --wraps=rg\ -Suu\ -g\ \'!\{.bzr,CVS,.git,.hg,.svn,.idea,.tox\}\' --description alias\ g=rg\ -Suu\ -g\ \'!\{.bzr,CVS,.git,.hg,.svn,.idea,.tox\}\'
    rg -Suu -g '!{.bzr,CVS,.git,.hg,.svn,.idea,.tox}' $argv
end
