set -l execs annotate \
    cap \
    cucumber \
    guard \
    puma \
    rackup \
    rails \
    rake \
    rspec \
    rubocop \
    sidekiq \
    spring

if set -q bundler_plugin_execs
    set execs $execs $bundler_plugin_execs
end

# Fish 2.1.1+ has support for --inherit-variable
set -l do_eval (echo $FISH_VERSION | grep 2.1.1-)

for executable in $execs
    if test -z "$do_eval"
        eval "function $executable; __execute_as_bundler $executable \$argv; end"
    else
        function $executable --inherit-variable executable
            __execute_as_bundler $executable $argv
        end
    end
end
