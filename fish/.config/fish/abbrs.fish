## bundler
abbr be bundle exec
abbr bi bundle install
abbr bout bundle outdated
abbr bu bundle update

## directories
abbr -- - 'cd -'
abbr dotdot --regex '^\.\.+$' --function __fish_multicd # cd .., cd ../..

## rust
abbr rbt RUST_BACKTRACE=1
abbr rld RUST_LOG=debug
abbr rli RUST_LOG=info

## other
abbr !! --position anywhere --function __fish_last_history_item
