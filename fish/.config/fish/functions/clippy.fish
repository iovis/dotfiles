function clippy --wraps='cargo clippy -- -W clippy::pedantic -Aclippy::missing-errors-doc -Aclippy::missing-panics-doc' --description 'alias clippy=cargo clippy -- -W clippy::pedantic -Aclippy::missing-errors-doc -Aclippy::missing-panics-doc'
    cargo clippy -- -W clippy::pedantic -Aclippy::missing-errors-doc -Aclippy::missing-panics-doc $argv
end
