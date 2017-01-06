#!/bin/bash
############################
# install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/.dotfiles
############################

########## Variables
dir=~/.dotfiles
olddir=~/dotfiles_old
sublime_dir="~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User"
files=".agignore .atom .bashrc .ctags .eslintrc.json .gemrc .gitconfig .gitignore_global .hyper.js .pryrc .psqlrc .tern-config .tmux.conf .vim .vimrc .zshrc"
config_files="mpv nvim"


# create dotfiles_old in homedir
mkdir -p $olddir
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -snf $dir/$file ~/$file
done

# Same for .config files and folders
mkdir ~/.config

for file in $config_files; do
    echo "Moving any existing dotfiles from ~/.config to $olddir"
    mv ~/.config/$file ~/dotfiles_old/
    echo "Creating symlink to $file in the config directory."
    ln -snf $dir/$file ~/.config/$file
done

# Sublime Text 3
echo "\nIf you want to sync Sublime Text, fire these"
echo "mv ${sublime_dir} ${olddir}"
echo "ln -snf ~/.dotfiles/sublime/User ${sublime_dir}"
