function notes --wraps=cd\ \'/Users/david/Library/Mobile\ Documents/com\~apple\~CloudDocs/notes\'\ \&\&\ nvim\ -S\ Session.vim\ +ZenMode --description alias\ notes=cd\ \'/Users/david/Library/Mobile\ Documents/com\~apple\~CloudDocs/notes\'\ \&\&\ nvim\ -S\ Session.vim\ +ZenMode
    cd "$NOTES" && nvim -S Session.vim +ZenMode $argv
end
