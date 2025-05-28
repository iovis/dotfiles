function npmci --wraps='rm -rf node_modules && npm ci'
    rm -rf node_modules && npm ci $argv
end
