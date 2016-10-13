#!/bin/bash
############################
# install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/.dotfiles
############################

########## Variables
dir=~/.dotfiles
olddir=~/dotfiles_old
files=".atom .zshrc .bashrc .vimrc .vim .tmux.conf .gitignore_global .gitconfig .tern-config .ctags .agignore .pryrc .psqlrc"
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

# Neovim
# ln -s ~/.dotfiles/.vim ~/.config/nvim
# ln -s ~/.dotfiles/.vimrc ~/.config/nvim/init.vim
