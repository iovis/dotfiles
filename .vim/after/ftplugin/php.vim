setlocal commentstring=//%s
command! -nargs=0 Phpformat silent !php-cs-fixer -q fix %
" setlocal makeprg=phpunit\ --configuration\ tests/phpunit.xml
