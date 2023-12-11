function clippy
    cargo clippy -- -W clippy::pedantic \
                    -A clippy::missing-errors-doc \
                    -A clippy::missing-panics-doc \
                    -A clippy::must-use-candidate \
                    -A clippy::needless_range_loop \
                    $argv
end
