function pedev --wraps='pipenv install --dev pylint ipython ipdb pynvim' --description 'alias pedev=pipenv install --dev pylint ipython ipdb pynvim'
    pipenv install --dev pylint ipython ipdb pynvim $argv
end
