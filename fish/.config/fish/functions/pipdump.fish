function pipdump --wraps='pip freeze > requirements.txt' --description 'alias pipdump=pip freeze > requirements.txt'
    pip freeze >requirements.txt $argv
end
