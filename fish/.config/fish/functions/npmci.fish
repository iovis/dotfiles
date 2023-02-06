function npmci --wraps='rm -rf node_modules && npm ci' --description 'alias npmci=rm -rf node_modules && npm ci'
    rm -rf node_modules && npm ci $argv
end
