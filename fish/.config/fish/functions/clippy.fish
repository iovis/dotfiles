function clippy
    cargo clippy --all-targets -- -W clippy::pedantic -A clippy::missing-errors-doc -A clippy::missing-panics-doc -A clippy::must-use-candidate $argv
end
