#!/bin/bash
############################
# install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/.dotfiles
############################

########## Variables
dir=~/.dotfiles
olddir=~/dotfiles_old
files=".agignore .bashrc .ctags .ctags.d .eslintrc.json .gemrc .gitconfig .gitignore_global .hyper.js .pryrc .psqlrc .tern-config .tmux.conf .vim .vimrc .zshrc"
config_files="mpv nvim"


# create dotfiles_old in homedir
mkdir -p $olddir
cd $dir || exit

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv "$HOME/$file" ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -snf "$dir/$file" "$HOME/$file"
done

# Same for .config files and folders
mkdir ~/.config

for file in $config_files; do
    echo "Moving any existing dotfiles from ~/.config to $olddir"
    mv "$HOME/.config/$file" ~/dotfiles_old/
    echo "Creating symlink to $file in the config directory."
    ln -snf "$dir/$file" "$HOME/.config/$file"
done
