setlocal commentstring=//%s
setlocal shiftwidth=4
setlocal tabstop=4
command! -nargs=0 Phpformat silent !php-cs-fixer -q fix %
" setlocal makeprg=phpunit\ --configuration\ tests/phpunit.xml
